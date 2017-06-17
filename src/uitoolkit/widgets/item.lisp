(in-package :graphic-forms.uitoolkit.widgets)

;;;
;;; helper functions
;;;

(defun create-item-with-callback (howner class-symbol thing disp)
  (let ((item nil))
    (cond
      ((null disp)
         (setf item (make-instance class-symbol :data thing :handle howner)))
      ((functionp disp)
         (setf item (make-instance class-symbol :data thing :handle howner :callback disp)))
      ((typep disp 'gfw:event-dispatcher)
         (setf item (make-instance class-symbol :data thing :handle howner :dispatcher disp)))
      (t
         (error 'gfs:toolkit-error
           :detail "callback must be a function, instance of gfw:event-dispatcher, or null")))
    item))

(defun items-equal (item1 item2)
  (= (item-id item1) (item-id item2)))

;;;
;;; methods
;;;

(defmethod check :before ((self item) flag)
  (declare (ignore flag))
  (if (gfs:null-handle-p (gfs:handle self))
    (error 'gfs:toolkit-error :detail "null owner handle")))

(defmethod checked-p :before ((self item))
  (if (gfs:null-handle-p (gfs:handle self))
    (error 'gfs:toolkit-error :detail "null owner handle")))

(defmethod gfs:dispose ((self item))
  (let ((hwnd (gfs:handle self)))
    (unless (or (null hwnd) (cffi:null-pointer-p hwnd))
      (let ((owner (get-widget (thread-context) hwnd)))
        (if owner
          (setf (slot-value owner 'items)
                (remove self (slot-value owner 'items) :test #'items-equal))))))
  (delete-tc-item (thread-context) self)
  (setf (slot-value self 'gfs:handle) nil))

(defmethod initialize-instance :after ((self item) &key callback &allow-other-keys)
  (setf (item-id self) (increment-item-id (thread-context)))
  (when callback
    (unless (typep callback 'function)
      (error 'gfs:toolkit-error :detail ":callback value must be a function"))
    (setf (dispatcher self)
          (make-instance (define-dispatcher (class-name (class-of self)) callback)))))

(defmethod owner ((self item))
  (let ((hwnd (gfs:handle self)))
    (if (gfs:null-handle-p hwnd)
      (error 'gfs:toolkit-error :detail "null owner widget handle"))
    (let ((widget (get-widget (thread-context) hwnd)))
      (if (null widget)
        (error 'gfs:toolkit-error :detail "no owner widget"))
      widget)))

(defmethod print-object ((self item) stream)
  (print-unreadable-object (self stream :type t)
    (format stream "id: ~d " (item-id self))
    (format stream "data: ~a " (data-of self))
    (format stream "handle: ~x " (gfs:handle self))
    (format stream "dispatcher: ~a" (dispatcher self))))
