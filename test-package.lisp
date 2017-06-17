(in-package :cl-user)

(defpackage #:graphic-forms.uitoolkit.tests
  (:nicknames #:gft)
  (:use :common-lisp :lisp-unit)
  (:export
   #:drawing-tester
   #:event-tester
   #:hello-world
   #:image-tester
   #:layout-tester
   #:scroll-tester
   #:widget-tester
   #:textedit
   #:unblocked
   #:windlg))

(in-package #:gft)

(defvar *gf-dir*              (asdf:system-source-directory "graphic-forms-uitoolkit"))
(defvar *gf-tests-dir*        (merge-pathnames "src/tests/" *gf-dir*))




