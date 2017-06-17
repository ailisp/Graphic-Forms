(in-package :graphic-forms.uitoolkit.system)

(defclass native-object ()
  ((handle
    :reader handle
    :initarg :handle
    :initform nil))
  (:documentation "This is the base class for all objects that have a native handle representation at the system level."))
