(in-package :graphic-forms.uitoolkit.tests)

(define-test class-registration-test
  (assert-true (> (gfw::register-panel-window-class) 0) 'gfw::register-panel-class)
  (assert-true (> (gfw::register-toplevel-erasebkgnd-window-class) 0) 'gfw::register-toplevel-erasebkgnd-window-class)
  (assert-true (> (gfw::register-toplevel-noerasebkgnd-window-class) 0) 'gfw::register-toplevel-noerasebkgnd-window-class)
  (assert-true (> (gfw::register-dialog-class) 0) 'gfw::register-dialog-class)

  ;; test registering them again
  ;;
  (assert-true (> (gfw::register-panel-window-class) 0) 'gfw::register-panel-class)
  (assert-true (> (gfw::register-toplevel-erasebkgnd-window-class) 0) 'gfw::register-toplevel-erasebkgnd-window-class)
  (assert-true (> (gfw::register-toplevel-noerasebkgnd-window-class) 0) 'gfw::register-toplevel-noerasebkgnd-window-class)
  (assert-true (> (gfw::register-dialog-class) 0) 'gfw::register-dialog-class))
