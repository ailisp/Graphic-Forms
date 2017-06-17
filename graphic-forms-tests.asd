(defsystem graphic-forms-tests
  :description "Graphic-Forms UI Toolkit Tests"
  :depends-on ("lisp-unit" "graphic-forms-uitoolkit")
  :components
  ((:file "test-package")
   (:module "src"
	    :depends-on ("test-package")
	    :components
	    ((:module "demos"
		      :components
		      ((:file "demo-utils")
		       (:module "textedit"
				:serial t
				:depends-on ("demo-utils")
				:components
				((:file "textedit-document")
				 (:file "textedit-window")))
		       (:module "unblocked"
				:serial t
				:depends-on ("demo-utils")
				:components
				((:file "tiles")
				 (:file "unblocked-model")
				 (:file "unblocked-controller")
				 (:file "double-buffered-event-dispatcher")
				 (:file "scoreboard-panel")
				 (:file "tiles-panel")
				 (:file "unblocked-window")))))
	     (:module "tests"
		      :components
		      ((:module "uitoolkit"
				:serial t
				:components
				(;;; unit tests
				 (:file "test-utils")
				 (:file "mock-objects")
				 (:file "color-unit-tests")
				 (:file "graphics-context-unit-tests")
				 (:file "image-unit-tests")
				 (:file "icon-bundle-unit-tests")
				 (:file "layout-unit-tests")
				 (:file "flow-layout-unit-tests")
				 (:file "widget-unit-tests")
				 (:file "item-manager-unit-tests")
				 (:file "misc-unit-tests")
				 (:file "border-layout-unit-tests")

				 ;;; small examples
				 (:file "hello-world")
				 (:file "event-tester")
				 (:file "layout-tester") ; this file finds out that callback sometimes doesn't work well with sbcl, but ok with ccl. try to fix the original sbcl callback patch
				 (:file "image-tester")
				 (:file "drawing-tester")
				 (:file "widget-tester")
				 (:file "scroll-grid-panel")
				 (:file "scroll-text-panel")
				 (:file "scroll-tester")
				 (:file "windlg")))))))))

