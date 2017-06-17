(in-package :graphic-forms.uitoolkit.widgets)

(defclass layout-manager ()
  ((style
    :accessor style-of
    :initarg :style
    :initform nil)
   (left-margin
    :accessor left-margin-of
    :initarg :left-margin
    :initform 0)
   (top-margin
    :accessor top-margin-of
    :initarg :top-margin
    :initform 0)
   (right-margin
    :accessor right-margin-of
    :initarg :right-margin
    :initform 0)
   (bottom-margin
    :accessor bottom-margin-of
    :initarg :bottom-margin
    :initform 0)
   (data
    :accessor data-of
    :initform nil))
  (:documentation "Subclasses implement layout strategies to manage space within windows."))

(defclass border-layout (layout-manager) ()
  (:documentation "Window children are assigned a position on the edges or center of a container."))

(defclass flow-layout (layout-manager)
  ((spacing
    :accessor spacing-of
    :initarg :spacing
    :initform 0))
  (:documentation "Window children are arranged in a row or column."))

(defclass heap-layout (layout-manager)
  ((top-child
    :accessor top-child-of
    :initarg :top-child
    :initform nil))
  (:documentation "Window children are stacked one on top of the other."))
