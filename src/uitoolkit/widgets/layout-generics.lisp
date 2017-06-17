(in-package :graphic-forms.uitoolkit.widgets)

(defgeneric compute-size (self win width-hint height-hint)
  (:documentation "Computes and returns the size of the window's client area based on the layout's strategy."))

(defgeneric compute-layout (self win width-hint height-hint)
  (:documentation "Returns a list of conses (window . rectangle) describing the new bounds of each child window."))

(defgeneric obtain-default (self)
  (:documentation "Returns an instance representing default values to be used when none is supplied by the application.")
  (:method (self)
    (declare (ignorable self))))

(defgeneric perform (self window widget-hint height-hint)
  (:documentation "Moves and resizes window children based on layout strategy."))
