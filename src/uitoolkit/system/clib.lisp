(in-package :graphic-forms.uitoolkit.system)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (use-package :cffi))

(load-foreign-library "msvcrt.dll")

(defcfun
  ("strncpy" strncpy)
  :pointer
  (dest :pointer)
  (src :pointer)
  (count :unsigned-int))
