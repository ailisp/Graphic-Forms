(in-package #:graphic-forms.uitoolkit.tests)

(defvar *scroll-tester-win* nil)

(defun scroll-tester-exit (disp item)
  (declare (ignore disp item))
  (gfs:dispose *scroll-tester-win*)
  (setf *scroll-tester-win* nil)
  (gfw:shutdown 0))

(defclass scroll-tester-events (gfw:scrolling-helper) ())

(defmethod gfw:event-close ((disp scroll-tester-events) window)
  (declare (ignore window))
  (scroll-tester-exit disp nil))

(defun scroll-tester-internal ()
  (setf *default-pathname-defaults* (merge-pathnames "uitoolkit/" *gf-tests-dir*))
  (let ((layout (make-instance 'gfw:heap-layout))
        (icons (make-instance 'gfg:icon-bundle :file (merge-pathnames "default.ico"))))
    (setf *scroll-tester-win* (make-instance 'gfw:top-level
                                             :dispatcher (make-instance 'scroll-tester-events)
                                             :layout layout
                                             :style '(:workspace :horizontal-scrollbar :vertical-scrollbar)))
    (setf (gfw:image *scroll-tester-win*) icons)
    (let* ((grid-panel (make-scroll-grid-panel *scroll-tester-win*))
           (text-panel (make-scroll-text-panel *scroll-tester-win*))
           (select-grid (lambda (disp item)
                          (declare (ignore disp item))
                          (setf (gfw:top-child-of layout) grid-panel)
                          (gfw:layout *scroll-tester-win*)
                          (set-grid-scroll-params *scroll-tester-win*)))
           (select-text (lambda (disp item)
                          (declare (ignore disp item))
                          (setf (gfw:top-child-of layout) text-panel)
                          (gfw:layout *scroll-tester-win*)
                          (set-text-scroll-params *scroll-tester-win*)))
           (manage-tests-menu (lambda (disp menu)
                                (declare (ignore disp))
                                (let ((top (gfw::obtain-top-child *scroll-tester-win*))
                                      (items (gfw:items-of menu)))
                                  (gfw:check (elt items 0) (eql top grid-panel))
                                  (gfw:check (elt items 1) (eql top text-panel)))))
           (menubar (gfw:defmenu ((:item    "&File"
                                   :submenu ((:item "E&xit"        :callback #'scroll-tester-exit)))
                                  (:item    "&Tests"               :callback manage-tests-menu
                                   :submenu ((:item "&Simple Grid" :callback select-grid)
                                             (:item "&Text"        :callback select-text)))))))
      (setf (gfw:menu-bar *scroll-tester-win*) menubar
            (gfw:top-child-of layout) grid-panel))
    (setf (gfw:text *scroll-tester-win*) "Scroll Tester"
          (gfw:size *scroll-tester-win*) (gfs:make-size :width 300 :height 275))
    (set-grid-scroll-params *scroll-tester-win*)
    (gfw:show *scroll-tester-win* t)))

(defun scroll-tester ()
  (gfw:startup "Scroll Tester" #'scroll-tester-internal))
