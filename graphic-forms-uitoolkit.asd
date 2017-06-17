(defsystem graphic-forms-uitoolkit
  :description "Graphic-Forms UI Toolkit"
  :depends-on ("cffi"
	       "lw-compat"
	       "closer-mop"
	       "com.gigamonkeys.macro-utilities"
	       "com.gigamonkeys.binary-data")
  :components
  ((:file "config")
   (:module "src"
	    :depends-on ("config")
	    :components
	    ((:file "packages")
	     (:module "uitoolkit"
		      :depends-on ("packages")
		      :components
		      ((:module "system" 
				:serial t
				:components
				(#+sbcl
				 (:file "sbcl-callback-hacking")
				 (:file "system-constants")
				 (:file "system-classes")
				 (:file "system-conditions") ; not a very good place
				 (:file "system-generics")
				 (:file "system-types")
				 (:file "datastructs")
				 (:file "clib")
				 (:file "comctl32")
				 (:file "comdlg32")
				 (:file "shell32")
				 (:file "gdi32")
				 (:file "kernel32")
				 (:file "user32")
				 (:file "native-object")
				 (:file "system-utils")
				 (:file "metrics")))
		       (:module "graphics"
				:depends-on ("system")
				:components
				((:file "graphics-constants")
				 (:file "graphics-classes")
				 (:file "graphics-generics")
				 (:file "color"
					:depends-on ("graphics-classes"))
				 (:file "palette"
					:depends-on ("graphics-classes"))
				 (:file "image-data"
					:depends-on ("graphics-classes"))
				 (:file "image"
					:depends-on ("graphics-classes" "graphics-generics"))
				 (:file "icon-bundle"
					:depends-on ("graphics-constants" "image"))
				 (:file "cursor"
					:depends-on ("graphics-classes" "image"))
				 (:file "font-data")
				 (:file "font")
				 (:file "graphics-context")
				 (:module "plugins"
					  :components
					  ((:file "graphics-plugin-packages")
					   #-skip-default-plugin        (:module "default"
										 :serial t
										 :components
										 ((:file "file-formats")
										  (:file "default-data-plugin")))
					   #+load-imagemagick-plugin    (:module "imagemagick"
										 :serial t
										 :components
										 ((:file "magick-core-types")
										  (:file "magick-core-api")
										  (:file "magick-data-plugin"
											 :depends-on ("magick-core-types" "magick-core-api"))))))))
		       (:module "widgets"
				:depends-on ("graphics")
				:serial t
				:components
				((:file "widget-constants")
				 (:file "widget-classes")
				 (:file "layout-classes")
				 (:file "thread-context") ; require defun in top-level.lisp
				 (:file "message-generics")
				 (:file "event-generics")
				 (:file "layout-generics")
				 (:file "widget-generics")
				 (:file "display")
				 (:file "event-source")
				 (:file "widget-utils")
				 (:file "timer")
				 (:file "item")
				 (:file "widget")
				 (:file "color-dialog")
				 (:file "file-dialog")
				 (:file "font-dialog")
				 (:file "control") ; require append-layout-item, subclass-wndproc
				 (:file "edit") 
				 (:file "label")
				 (:file "button")
				 (:file "item-manager") 
				 (:file "list-item") ; require lb-select-item lb-deselect-item
				 (:file "list-box")
				 (:file "menu")
				 (:file "menu-item")
				 (:file "defmenu")
				 (:file "progress-bar")
				 (:file "event") ; require set-window-origin
				 (:file "scrolling-helper") ; require obtain-top-child
				 (:file "scrollbar") 
				 (:file "slider")
				 (:file "status-bar")
				 (:file "window") ; require arrang-hwnds
				 (:file "root-window")
				 (:file "top-level")
				 (:file "panel")
				 (:file "dialog")
				 (:file "layout")
				 (:file "border-layout")
				 (:file "heap-layout")
				 (:file "flow-layout")
				 (:file "defwindow")))))))))

(defmethod perform :after ((op load-op) (c (eql (find-system :graphic-forms-uitoolkit))))
  (pushnew :graphic-forms *features*))
