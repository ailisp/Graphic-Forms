(in-package :graphic-forms.uitoolkit.widgets)

(defparameter *panel-window-classname* "GraphicFormsPanel")

;;;
;;; helper functions
;;;

(defun register-panel-window-class ()
  (register-window-class *panel-window-classname*
                         (cffi:get-callback 'uit_widgets_wndproc)
                         gfs::+cs-dblclks+
                         -1))

;;;
;;; methods
;;;

(defmethod compute-outer-size ((self panel) desired-client-size)
  (declare (ignore self))
  (gfs:copy-size desired-client-size))

(defmethod compute-style-flags ((self panel) &rest extra-data)
  (declare (ignore extra-data))
  (let ((std-flags (logior gfs::+ws-clipchildren+ gfs::+ws-clipsiblings+ gfs::+ws-child+ gfs::+ws-visible+)))
    (loop for sym in (style-of self)
          do (ecase sym
                ;; styles that can be combined
                ;;
               (:border
                  (setf std-flags (logior std-flags gfs::+ws-border+)))
               (:horizontal-scrollbar
                  (setf std-flags (logior std-flags gfs::+ws-hscroll+)))
               (:vertical-scrollbar
                  (setf std-flags (logior std-flags gfs::+ws-vscroll+)))))
    (values std-flags gfs::+ws-ex-controlparent+)))

(defmethod initialize-instance :after ((self panel) &key parent &allow-other-keys)
  (if (null parent)
    (error 'gfs:toolkit-error :detail "parent is required for panel"))
  (if (gfs:disposed-p parent)
    (error 'gfs:disposed-error))
  (init-window self *panel-window-classname* #'register-panel-window-class parent ""))
