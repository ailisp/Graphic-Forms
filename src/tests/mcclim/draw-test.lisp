(in-package :clim-user)

(define-application-frame test ()
  ()
  (:panes
   (display :application))
  (:layouts
   (default display)))

(define-test-command (com-quit :menu t) ()
  (frame-exit *application-frame*))

(defvar *test-frame* nil)

(defun test ()
  (flet ((run ()
	   (let ((frame (make-application-frame 'test)))
	     (setq *test-frame* frame) (run-frame-top-level frame))))
    (bt:make-thread #'run :name "test")))
