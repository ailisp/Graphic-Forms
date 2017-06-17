(in-package :graphic-forms.uitoolkit.widgets)

(defparameter *callback-info* '((gfw:event-activate . (gfw:event-source))
                                (gfw:event-arm      . (gfw:event-source))
                                (gfw:event-modify   . (gfw:event-source))
                                (gfw:event-select   . (gfw:event-source))
                                (gfw:event-scroll   . (gfw:event-source symbol symbol))))

(defun make-specializer-list (disp-class arg-info)
  (let ((tmp (mapcar #'find-class arg-info)))
    (push disp-class tmp)
    tmp))

(defun define-dispatcher-for-callbacks (callbacks)
  (let ((*print-gensym* nil)
        (class (c2mop:ensure-class (gentemp "EDCLASS" :gfgen)
                                  :direct-superclasses '(event-dispatcher))))
    (loop for pair in callbacks
          do (let* ((method-sym (car pair))
                    (fn (cdr pair))
                    (arg-info (cdr (assoc method-sym *callback-info*)))
                    (args nil))
              `(unless (or (symbolp ,fn) (functionp ,fn))
                 (error 'gfs:toolkit-error
                        :detail "callback must be function or symbol naming function"))
               (if (null arg-info)
                 (error 'gfs:toolkit-error :detail (format nil
                                                           "unsupported event method for callbacks: ~a"
                                                           method-sym)))
               (dotimes (i (1+ (length arg-info)))
                 (push (gentemp "ARG" :gfgen) args))
               (c2mop:ensure-method (ensure-generic-function method-sym :lambda-list args)
                                    `(lambda ,args (funcall ,fn ,@args))
                                    :specializers (make-specializer-list class arg-info))))
    class))

(defun define-dispatcher (classname callback)
  (let ((proto (c2mop:class-prototype (find-class classname))))
    (define-dispatcher-for-callbacks `((,(callback-event-name-of proto) . ,callback)))))

;;;
;;; methods
;;;

(defmethod initialize-instance :after ((self event-source) &key callbacks dispatcher &allow-other-keys)
  (unless (or dispatcher (null callbacks))
    (let ((class (define-dispatcher-for-callbacks callbacks)))
      (setf (dispatcher self) (make-instance (class-name class))))))

(defmethod owner :before ((self event-source))
  (if (gfs:disposed-p self)
    (error 'gfs:disposed-error)))

(defmethod parent :before ((self event-source))
  (if (gfs:disposed-p self)
    (error 'gfs:disposed-error)))

(defmethod print-object ((self event-source) stream)
  (print-unreadable-object (self stream :type t)
    (format stream "handle: ~x " (gfs:handle self))
    (format stream "dispatcher: ~a " (dispatcher self))))
