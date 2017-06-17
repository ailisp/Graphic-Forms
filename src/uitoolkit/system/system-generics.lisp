(in-package :graphic-forms.uitoolkit.system)

(defgeneric dispose (native-object)
  (:documentation "Discards native resources and executes other cleanup code."))

(defgeneric disposed-p (native-object)
  (:documentation "Returns T if the target has had dispose called; nil otherwise."))
