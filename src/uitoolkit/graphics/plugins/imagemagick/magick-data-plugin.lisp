(in-package :graphic-forms.uitoolkit.graphics.imagemagick)

(defclass magick-data-plugin (gfg:image-data-plugin) ()
  (:documentation "ImageMagick library plugin for the graphics package."))

(defun loader (path)
  (unless *magick-initialized*
    (initialize-magick (cffi:null-pointer))
    (setf *magick-initialized* t))
  (if (gethash (string-downcase (pathname-type path)) gfg:*image-file-types*)
    (with-image-path ((if (typep path 'pathname) (namestring path) path) info ex)
      (let ((images-ptr (read-image info ex)))
        (if (not (eql (cffi:foreign-slot-value ex 'exception-info 'severity) :undefined))
          (error 'gfs:toolkit-error :detail (format nil
                                                    "exception reason: ~s"
                                                    (cffi:foreign-slot-value ex 'exception-info 'reason))))
        (loop for ptr = images-ptr then (get-next-image-in-list ptr)
              while (and ptr (not (gfs:null-handle-p ptr)))
              collect (make-instance 'magick-data-plugin :handle ptr))))
    nil))

(push #'loader gfg::*image-plugins*)

(defmethod gfg:depth ((self magick-data-plugin))
  ;; FIXME: further debugging of non-true-color format required throughout
  ;; this plugin, reverting back to assumption of 32bpp for now.
#|
  (let ((handle (gfs:handle self)))
    (if (null handle)
      (error 'gfs:disposed-error))
    (cffi:foreign-slot-value handle 'magick-image 'depth)))
|#
  32)

(defmethod gfs:dispose ((self magick-data-plugin))
  (let ((victim (gfs:handle self)))
    (unless (or (null victim) (cffi:null-pointer-p victim))
      (destroy-image victim)))
  (setf (slot-value self 'gfs:handle) nil))

(defmethod gfg:copy-pixels ((self magick-data-plugin) pixels-pointer)
  (let* ((handle (gfs:handle self))
         (im-size (gfg:size self))
         (pixel-count (* (gfs:size-width im-size) (gfs:size-height im-size)))
         (pix-tmp (get-image-pixels handle 0 0 (gfs:size-width im-size) (gfs:size-height im-size))))
    (dotimes (i pixel-count)
      (cffi:with-foreign-slots ((blue green red reserved)
                                (cffi:mem-aptr pix-tmp '(:struct pixel-packet) i) (:struct pixel-packet))
        (cffi:with-foreign-slots ((gfs::rgbred gfs::rgbgreen gfs::rgbblue gfs::rgbreserved)
                                  (cffi:mem-aref pixels-pointer '(:struct gfs::rgbquad) i) (:struct gfs::rgbquad))
          (setf gfs::rgbreserved 0
                gfs::rgbred      (scale-quantum-to-byte red)
                gfs::rgbgreen    (scale-quantum-to-byte green)
                gfs::rgbblue     (scale-quantum-to-byte blue))))))
  pixels-pointer)

(defmethod gfg:size ((self magick-data-plugin))
  (let ((handle (gfs:handle self))
        (size (gfs:make-size)))
    (if (or (null handle) (cffi:null-pointer-p handle))
      (error 'gfs:disposed-error))
    (cffi:with-foreign-slots ((rows columns) handle magick-image)
      (setf (gfs:size-height size) rows)
      (setf (gfs:size-width size) columns))
    size))

(defmethod (setf gfg:size) (size (self magick-data-plugin))
  (let ((handle (gfs:handle self))
        (new-handle (cffi:null-pointer))
        (ex (acquire-exception-info)))
    (if (or (null handle) (cffi:null-pointer-p handle))
      (error 'gfs:disposed-error))
    (unwind-protect
        (progn
          (setf new-handle (resize-image handle
                                         (gfs:size-width size)
                                         (gfs:size-height size)
                                         (cffi:foreign-enum-value 'filter-types :lanczos)
                                         1.0 ex))
          (if (gfs:null-handle-p new-handle)
            (error 'gfs:toolkit-error :detail (format nil
                                                      "could not resize: ~a"
                                                      (cffi:foreign-slot-value ex
                                                                               'exception-info
                                                                               'reason))))
          (setf (slot-value self 'gfs:handle) new-handle)
          (destroy-image handle))
      (destroy-exception-info ex)))
  size)

(defmethod cffi:translate-to-foreign ((lisp-obj magick-data-plugin)
                                      (type gfs::bitmapinfo-pointer-type))
  ;; FIXME: assume true-color for now
  ;;
  (gfg::make-initial-bitmapinfo lisp-obj))
