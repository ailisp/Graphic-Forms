(in-package :graphic-forms.uitoolkit.graphics)

;;;
;;; methods
;;;

(defmethod data-object ((self font) &optional gc)
  (if (null gc)
    (error 'gfs:toolkit-error :detail "gc argument required when calling data-object for font"))
  (if (or (gfs:disposed-p self) (gfs:disposed-p gc))
    (error 'gfs:disposed-error))
  (font->data (gfs:handle gc) (gfs:handle self)))

(defmethod gfs:dispose ((self font))
  (let ((hgdi (gfs:handle self)))
    (unless (gfs:null-handle-p hgdi)
      (gfs::delete-object hgdi)))
  (setf (slot-value self 'gfs:handle) nil))

(defmethod initialize-instance :after ((self font) &key gc data &allow-other-keys)
  (when (or gc data)
    (unless (and gc data (typep gc 'graphics-context) (typep data 'font-data))
      (error 'gfs:toolkit-error :detail "font initialize-instance requires graphics-context and font-data"))
    (setf (slot-value self 'gfs:handle) (data->font (gfs:handle gc) data))))
