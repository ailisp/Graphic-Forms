(in-package :graphic-forms.uitoolkit.graphics)

;;;
;;; functions
;;;


;;;
;;; methods
;;;

(defmethod gfs:dispose ((self cursor))
  (if (gfs:disposed-p self)
    (warn 'gfs:toolkit-warning :detail "cursor already disposed"))
  (unless (sharedp self)
    (gfs::destroy-cursor (gfs:handle self)))
  (setf (slot-value self 'gfs:handle) nil))

(defmethod initialize-instance :after ((self cursor) &key file hotspot image system
                                                     &allow-other-keys)
  (let ((resource-id (if system (cffi:make-pointer system))))
    (cond
      (resource-id
        (setf (slot-value self 'gfs:handle)
              (gfs::load-image (cffi:null-pointer)
                               resource-id
                               gfs::+image-cursor+
                               0 0
                               (logior gfs::+lr-defaultsize+ gfs::+lr-shared+)))
        (setf (slot-value self 'shared) t))
      (file
        (let ((tmp (make-instance 'image :file file)))
          (setf (slot-value self 'gfs:handle) (image->hicon tmp))))
      ((typep image 'image)
        (setf (slot-value self 'gfs:handle) (image->hicon image hotspot))))))
