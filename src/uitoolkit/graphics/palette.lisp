(in-package :graphic-forms.uitoolkit.graphics)

#|
(defun pixel-color (pal pixel-val)
  "Returns the color struct corresponding to the given pixel value; the inverse of the pixel function."
  (if (direct-p pal)
    (error 'toolkit-error :detail "not yet implemented")
    (aref (palette-table pal) pixel-val)))
|#

(defun dump-colors (pal)
  (let* ((tmp (palette-table pal))
         (len (length tmp)))
    (when (zerop len)
      (format t "<empty color table>~%"))
    (dotimes (i len)
      (let ((clr (aref tmp i)))
        (format t "(~a,~a,~a)" (color-red clr) (color-green clr) (color-blue clr))))))

(defmethod print-object ((obj palette) stream)
  (print-unreadable-object (obj stream :type t)
    (format stream "direct: ~a " (palette-direct obj))
    (format stream "mask: (~a,~a,~a) "
                   (palette-red-mask obj)
                   (palette-green-mask obj)
                   (palette-blue-mask obj))
    (format stream "shift: (~a,~a,~a) "
                   (palette-red-shift obj)
                   (palette-green-shift obj)
                   (palette-blue-shift obj))
    (format stream "table: ")
    (dump-colors obj)))

(defmethod size ((obj palette))
  (length (palette-table obj)))
