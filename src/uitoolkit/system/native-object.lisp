(in-package :graphic-forms.uitoolkit.system)

(defmethod disposed-p ((obj native-object))
  (null (handle obj)))

(declaim (inline null-handle-p))
(defun null-handle-p (handle)
  (cffi:null-pointer-p handle))
