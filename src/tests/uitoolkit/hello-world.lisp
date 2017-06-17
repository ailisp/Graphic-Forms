(in-package #:graphic-forms.uitoolkit.tests)

(defvar *hello-win* nil)

(defclass hellowin-events (gfw:event-dispatcher) ())

(defun exit-fn (disp item)
  (declare (ignore disp item))
  (gfs:dispose *hello-win*)
  (setf *hello-win* nil)
  (gfw:shutdown 0))

(defmethod gfw:event-close ((disp hellowin-events) window)
  (declare (ignore window))
  (exit-fn disp nil))

(defmethod gfw:event-paint ((disp hellowin-events) window gc rect)
  (declare (ignore window rect))
  (gfg:clear gc gfg:*color-white-smoke*)
  (setf (gfg:background-color gc) gfg:*color-red*)
  (setf (gfg:foreground-color gc) gfg:*color-green*)
  (gfg:draw-text gc "Hello World!" (gfs:make-point)))

(defun hello-world-internal ()
  (let ((menubar nil))
    (setf *hello-win* (make-instance 'gfw:top-level :dispatcher (make-instance 'hellowin-events)
                                                    :style '(:frame)))
    (setf menubar (gfw:defmenu ((:item "&File"
                                 :submenu ((:item "E&xit" :callback #'exit-fn))))))
    (setf (gfw:menu-bar *hello-win*) menubar)
    (gfw:show *hello-win* t)))

(defun hello-world ()
  (gfw:startup "Hello World" #'hello-world-internal))
