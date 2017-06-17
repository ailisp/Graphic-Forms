(in-package :graphic-forms.uitoolkit.system)

(defstruct point (x 0) (y 0) (z 0))

(defstruct size (width 0) (height 0) (depth 0))

(defstruct rectangle (location (make-point)) (size (make-size)))

(defstruct span (start 0) (end 0))

(declaim (inline create-rectangle))
(defun create-rectangle (&key (height 0) (width 0) (x 0) (y 0))
  (make-rectangle :location (make-point :x x :y y)
                  :size (make-size :width width :height height)))

(declaim (inline location))
(defun location (rect)
  (rectangle-location rect))

(defun (setf location) (pnt rect)
  (setf (rectangle-location rect) pnt))

(declaim (inline size))
(defun size (size)
  (rectangle-size size))

(defun (setf size) (size rect)
  (setf (rectangle-size rect) size))

(declaim (inline empty-span-p))
(defun empty-span-p (span)
  (= (span-start span) (span-end span)))

(defun equal-point-p (point1 point2)
  (and (= (point-x point1) (point-x point2))
       (= (point-y point1) (point-y point2))))

(defun equal-size-p (size1 size2)
  (and (= (size-width size1) (size-width size2))
       (= (size-height size1) (size-height size2))))

(defmethod cffi:free-translated-object (ptr (type point-pointer-type) param)
  (declare (ignore param))
  (cffi:foreign-free ptr))

(defmethod cffi:free-translated-object (ptr (type rect-pointer-type) param)
  (declare (ignore param))
  (cffi:foreign-free ptr))

(defmethod cffi:translate-from-foreign (ptr (type point-pointer-type))
  (if (cffi:null-pointer-p ptr)
    (make-point)
    (cffi:with-foreign-slots ((x y) ptr (:struct point))
      (make-point :x x :y y))))

;; TODO: CFFI has changed?
(defmethod cffi:translate-from-foreign (ptr (type point-tclass))
  (if (cffi:null-pointer-p ptr)
    (make-point)
    (cffi:with-foreign-slots ((x y) ptr (:struct point))
      (make-point :x x :y y))))

(defmethod cffi:translate-from-foreign (ptr (type rect-pointer-type))
  (if (cffi:null-pointer-p ptr)
    (make-rectangle)
    (cffi:with-foreign-slots ((left top right bottom) ptr (:struct rect))
      (let ((pnt (make-point :x left :y top))
            (size (make-size :width (- right left) :height (- bottom top))))
        (make-rectangle :location pnt :size size)))))

(defmethod cffi:translate-to-foreign ((lisp-pnt point) (type point-pointer-type))
  (let ((ptr (cffi:foreign-alloc '(:struct point))))
    (cffi:with-foreign-slots ((x y) ptr (:struct point))
      (setf x (point-x lisp-pnt)
            y (point-y lisp-pnt)))
    ptr))

(defmethod cffi:translate-to-foreign ((lisp-pnt point) (type point-tclass))
  (let ((ptr (cffi:foreign-alloc '(:struct point))))
    (cffi:with-foreign-slots ((x y) ptr (:struct point))
      (setf x (point-x lisp-pnt)
            y (point-y lisp-pnt)))
    ptr))

(defmethod cffi:translate-to-foreign ((lisp-rect rectangle) (type rect-pointer-type))
  (let ((ptr (cffi:foreign-alloc '(:struct rect)))
        (pnt (location lisp-rect))
        (size (size lisp-rect)))
    (cffi:with-foreign-slots ((left top right bottom) ptr (:struct rect))
      (setf left   (gfs:point-x pnt)
            top    (gfs:point-y pnt)
            right  (+ (gfs:point-x pnt) (gfs:size-width size))
            bottom (+ (gfs:point-y pnt) (gfs:size-height size))))
    ptr))
