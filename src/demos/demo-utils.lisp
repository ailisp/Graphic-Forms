(in-package :graphic-forms.uitoolkit.tests)

(defclass demo-about-dialog-events (gfw:event-dispatcher) ())

(defmethod gfw:event-close ((disp demo-about-dialog-events) (dlg gfw:dialog))
  (call-next-method)
  (gfs:dispose dlg))

(defun about-demo (owner image-path title desc)
  (let* ((image (make-instance 'gfg:image :file image-path))
         (dlg (make-instance 'gfw:dialog :owner owner
                                         :dispatcher (make-instance 'demo-about-dialog-events)
                                         :layout (make-instance 'gfw:flow-layout
                                                                :margins 8
                                                                :spacing 8)
                                         :style '(:owner-modal)
                                         :text title))
         (label (make-instance 'gfw:label :parent dlg))
         (text-panel (make-instance 'gfw:panel
                                    :layout (make-instance 'gfw:flow-layout
                                                           :margins 0
                                                           :spacing 2
                                                           :style '(:vertical))
                                    :parent dlg))
         (line1 (make-instance 'gfw:label
                               :parent text-panel
                               :text desc))
         (line2 (make-instance 'gfw:label
                               :parent text-panel
                               :text " "))
         (line3 (make-instance 'gfw:label
                               :parent text-panel
                               :text (format nil "Copyright (C) 2006-2007 by Jack D. Unrue")))
         (line4 (make-instance 'gfw:label
                               :parent text-panel
                               :text "All Rights Reserved."))
         (line5 (make-instance 'gfw:label
                               :parent text-panel
                               :text " "))
         (line6 (make-instance 'gfw:label
                               :parent text-panel
                               :text " "))
         (btn-panel (make-instance 'gfw:panel
                                   :parent dlg
                                   :layout (make-instance 'gfw:flow-layout
                                                          :margins 0
                                                          :spacing 0
                                                          :style '(:vertical :normalize))))
         (close-btn (make-instance 'gfw:button
                                   :callback (lambda (disp btn)
                                               (declare (ignore disp btn))
                                               (gfs:dispose dlg))
                                   :style '(:default-button)
                                   :text "Close"
                                   :parent btn-panel)))
    (declare (ignore line1 line2 line3 line4 line5 line6 close-btn))
    (unwind-protect
        (gfg:with-image-transparency (image (gfs:make-point))
          (setf (gfw:image label) image))
      (gfs:dispose image))
    (gfw:pack dlg)
    (gfw:center-on-owner dlg)
    (gfw:show dlg t)))
