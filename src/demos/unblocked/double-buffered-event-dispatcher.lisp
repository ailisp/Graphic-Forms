(in-package :graphic-forms.uitoolkit.tests)

(defvar *background-color* (gfg:make-color :red 0 :green #x80 :blue #x80))

(defgeneric update-buffer (disp)
  (:documentation "Revises the image buffer so that the associated window can be repainted.")
  (:method (disp)
    (declare (ignorable disp))))

(defclass double-buffered-event-dispatcher (gfw:event-dispatcher)
  ((image-buffer
    :accessor image-buffer-of
    :initform nil)))

(defmethod clear-buffer ((self double-buffered-event-dispatcher) gc)
  (gfg:clear gc *background-color*))

(defmethod dispose ((self double-buffered-event-dispatcher))
  (let ((image (image-buffer-of self)))
    (unless (or (null image) (gfs:disposed-p image))
      (gfs:dispose image))
    (setf (image-buffer-of self) nil)))

(defmethod initialize-instance :after ((self double-buffered-event-dispatcher) &key buffer-size)
  (setf (image-buffer-of self) (make-instance 'gfg:image :size buffer-size)))

(defmethod gfw:event-paint ((self double-buffered-event-dispatcher) window gc rect)
  (declare (ignore window rect))
  (gfg:draw-image gc (image-buffer-of self) (gfs:make-point)))
