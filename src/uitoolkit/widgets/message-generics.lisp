(in-package :graphic-forms.uitoolkit.widgets)

(defgeneric process-message (object msg wparam lparam)
  (:documentation "Process window system messages for UIT-defined window classes. Return an integer status value."))

(defgeneric process-subclass-message (object msg wparam lparam)
  (:documentation "Process window system messages for subclassed system UI objects. Return an integer status value."))
