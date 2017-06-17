(in-package :graphic-forms.uitoolkit.graphics)

;;;
;;; helper functions
;;;

(defun hicon->image (hicon)
  (cffi:with-foreign-object (info-ptr '(:struct gfs::iconinfo))
    (gfs::zero-mem info-ptr (:struct gfs::iconinfo))
    (if (zerop (gfs::get-icon-info hicon info-ptr))
      (error 'gfs:win32-error :detail "get-icon-info failed"))
    (cffi:with-foreign-slots ((gfs::hmask gfs::hcolor) info-ptr (:struct gfs::iconinfo))
      (gfs::delete-object gfs::hmask)
      (make-instance 'image :handle gfs::hcolor))))

(defun image->hicon (image &optional point)
  (unless (typep point 'gfs:point)
    (setf point (transparency-pixel-of image))
    (unless point
      (setf point (gfs:make-point))))
  (cffi:with-foreign-object (info-ptr '(:struct gfs::iconinfo))
    (cffi:with-foreign-slots ((gfs::flag gfs::hcolor gfs::hmask) info-ptr (:struct gfs::iconinfo))
      (gfs::zero-mem info-ptr (:struct gfs::iconinfo))
      (setf gfs::flag 1)
      (with-image-transparency (image point)
        (setf gfs::hcolor (gfs:handle image))
        (setf gfs::hmask (gfs:handle (transparency-mask image)))
        (let ((hicon (gfs::create-icon-indirect info-ptr)))
          (if (gfs:null-handle-p hicon)
            (error 'gfs:win32-error :detail "create-icon-indirect failed"))
          hicon)))))

(defun icon-extent (hicon)
  (let ((im (hicon->image hicon))
        (extent 0))
    (unwind-protect
        (let ((size (gfg:size im)))
          (setf extent (* (gfs:size-height size) (gfs:size-width size))))
      (gfs:dispose im))
    extent))

(defun icon-handle-ref (bundle index)
  (let ((handles (gfs:handle bundle)))
    (unless handles
      (error 'gfs:disposed-error))
    (cond
      ((typep index 'integer)
         (if (listp handles)
           (if (< index (length handles))
             (elt handles index)
             (error 'gfs:toolkit-error :detail "invalid image index"))
           (if (zerop index)
             handles
             (error 'gfs:toolkit-error :detail "invalid image index"))))
      ((eql index :small)
         (if (listp handles)
           (first (sort (copy-list handles) #'< :key #'icon-extent))
           handles))
      ((eql index :large)
         (if (listp handles)
           (first (sort (copy-list handles) #'> :key #'icon-extent))
           handles))
      (t
         (error 'gfs:toolkit-error
                :detail "an integer index, or one of :small or :large, is required")))))

(defsetf icon-handle-ref (bundle index) (hicon)
  `(progn
     (if (gfs:null-handle-p ,hicon)
       (error 'gfs:disposed-error))
     (cond
       ((listp (gfs:handle ,bundle))
          (replace (gfs:handle ,bundle) (list ,hicon) :start1 ,index))
       ((and (zerop ,index) (not (null (gfs:handle ,bundle))))
          (setf (slot-value ,bundle 'gfs:handle) ,hicon))
       (t
          (error 'gfs:toolkit-error :detail "illegal arguments for (setf icon-handle-ref)")))
     ,hicon))

(defun icon-image-ref (bundle index)
  (hicon->image (icon-handle-ref bundle index)))

(defun set-icon-image (bundle index image)
  (let ((hicon (icon-handle-ref bundle index)))
    (if (and (not (gfs:null-handle-p hicon)) (listp (gfs:handle bundle)))
      (gfs::destroy-icon hicon)))
  (setf (icon-handle-ref bundle index) (image->hicon image)))

(defsetf icon-image-ref set-icon-image)

(defun icon-bundle-length (bundle)
  (let ((handles (gfs:handle bundle)))
    (unless handles
      (error 'gfs:disposed-error))
    (if (listp handles)
      (length handles)
      1)))

(defun push-icon-image (image bundle &optional transparency-pixel)
  (if (gfs:disposed-p image)
    (error 'gfs:disposed-error))
  (let ((tmp (gfs:handle bundle)))
    (push (image->hicon image transparency-pixel) tmp)
    (setf (slot-value bundle 'gfs:handle) tmp))
  bundle)

;;;
;;; methods
;;;

(defmethod gfs:dispose ((self icon-bundle))
  (let ((handles (gfs:handle self)))
    (setf (slot-value self 'gfs:handle) nil)
    ;; note: if handles is a cffi:pointer, then self was
    ;; instantiated as a system icon and we don't need
    ;; to destroy the handle
    ;;
    (if (and handles (listp handles))
      (loop for hicon in handles do (gfs::destroy-icon hicon)))))

(defmethod initialize-instance :after ((self icon-bundle) &key file images system transparency-pixel)
  (let ((image-list nil)
        (resource-id (if system (cffi:make-pointer system))))
    (cond
      (resource-id
         (setf (slot-value self 'gfs:handle) (gfs::load-icon (cffi:null-pointer) resource-id)))
      ((typep file 'pathname)
         (let ((data (load-image-data file)))
           (setf image-list (loop for entry in data
                                  collect (make-instance 'gfg:image :handle (plugin->image entry))))))
      ((listp images)
         (setf image-list images)))
    (when image-list
      (let ((tr-pnt (or transparency-pixel (gfs:make-point))))
        (setf (slot-value self 'gfs:handle) (loop for tmp-image in image-list
                                                  collect (image->hicon tmp-image tr-pnt)))))))
