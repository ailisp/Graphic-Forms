(in-package :graphic-forms.uitoolkit.widgets)

;;;
;;; macros and helper functions
;;;

(defmacro with-root-window ((win) &body body)
  `(let ((,win (make-instance 'root-window)))
     (unwind-protect
         (progn
           ,@body)
       (gfs:dispose ,win))))

;;;
;;; methods
;;;

(defmethod gfs:dispose ((self root-window))
  (setf (slot-value self 'gfs:handle) nil))

(defmethod (setf dispatcher) (disp (self root-window))
  (declare (ignore disp))
  (error 'gfs:toolkit-error :detail "The root window cannot be assigned an event-dispatcher."))

(defmethod enable ((self root-window) flag)
  (declare (ignore flag))
  (error 'gfs:toolkit-error :detail "The root window cannot be enabled or disabled."))

(defmethod enable-layout ((self root-window) flag)
  (declare (ignore flag))
  (error 'gfs:toolkit-error :detail "The root window has no layout functionality."))

(defmethod initialize-instance :after ((self root-window) &key)
  (setf (slot-value self 'gfs:handle) (gfs::get-desktop-window)))

(defmethod (setf location) (pnt (self root-window))
  (declare (ignore pnt))
  (error 'gfs:toolkit-error :detail "The root window cannot be repositioned."))

(defmethod layout ((self root-window))
  (error 'gfs:toolkit-error :detail "The root window has no layout functionality."))

(defmethod owner ((self root-window))
  nil)

(defmethod pack ((self root-window))
  (error 'gfs:toolkit-error :detail "The root window has no layout functionality."))

(defmethod parent ((self root-window))
  nil)

(defmethod show ((self root-window) flag)
  (declare (ignore flag))
  (error 'gfs:toolkit-error :detail "The root window cannot be shown or hidden."))

(defmethod text ((self root-window))
  (error 'gfs:toolkit-error :detail "The root window has no title."))

(defmethod (setf text) (str (self root-window))
  (declare (ignore str))
  (error 'gfs:toolkit-error :detail "The root window has no title."))
