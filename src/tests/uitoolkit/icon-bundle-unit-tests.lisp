(in-package :graphic-forms.uitoolkit.tests)

(define-test bmp-file-icon-bundle-test
  (let ((bundle (make-instance 'gfg:icon-bundle :file (merge-pathnames "uitoolkit/happy.bmp" *gf-tests-dir*)))
        (size (gfs:make-size :width 32 :height 32)))
    (unwind-protect
        (progn
          (assert-equal 1 (gfg:icon-bundle-length bundle))
          (validate-image (gfg:icon-image-ref bundle 0) size 8)
          (validate-image (gfg:icon-image-ref bundle :large) size 8)
          (validate-image (gfg:icon-image-ref bundle :small) size 8))
      (gfs:dispose bundle))
    (assert-true (gfs:disposed-p bundle))))

(define-test images-icon-bundle-test
  (let ((bundle (make-instance 'gfg:icon-bundle
                               :images (list (make-instance 'gfg:image :file (merge-pathnames "uitoolkit/happy.bmp" *gf-tests-dir*))
                                             (make-instance 'gfg:image :file (merge-pathnames "uitoolkit/blackwhite20x16.bmp" *gf-tests-dir*))
                                             (make-instance 'gfg:image :file (merge-pathnames "uitoolkit/truecolor16x16.bmp" *gf-tests-dir*)))))
        (happy-size (gfs:make-size :width 32 :height 32))
        (bw-size (gfs:make-size :width 20 :height 16))
        (tc-size (gfs:make-size :width 16 :height 16)))
    (unwind-protect
        (progn
          (assert-equal 3 (gfg:icon-bundle-length bundle))
          (validate-image (gfg:icon-image-ref bundle 0) happy-size 8)
          (validate-image (gfg:icon-image-ref bundle 1) bw-size 8)
          (validate-image (gfg:icon-image-ref bundle 2) tc-size 16000000)
          (validate-image (gfg:icon-image-ref bundle :small) tc-size 8)
          (validate-image (gfg:icon-image-ref bundle :large) happy-size 8))
      (gfs:dispose bundle))
    (assert-true (gfs:disposed-p bundle))))

(define-test push-images-icon-bundle-test
  (let ((bundle (make-instance 'gfg:icon-bundle))
        (happy-image (make-instance 'gfg:image :file (merge-pathnames "uitoolkit/happy.bmp" *gf-tests-dir*)))
        (bw-image (make-instance 'gfg:image :file (merge-pathnames "uitoolkit/blackwhite20x16.bmp" *gf-tests-dir*)))
        (tc-image (make-instance 'gfg:image :file (merge-pathnames "uitoolkit/truecolor16x16.bmp" *gf-tests-dir*)))
        (happy-size (gfs:make-size :width 32 :height 32))
        (bw-size (gfs:make-size :width 20 :height 16))
        (tc-size (gfs:make-size :width 16 :height 16))
        (bw-point (gfs:make-point :x 0 :y 15)))
    (unwind-protect
        (progn
          (gfg:push-icon-image bw-image bundle bw-point)
          (gfg:push-icon-image tc-image bundle)
          (gfg:push-icon-image happy-image bundle)
          (assert-equal 3 (gfg:icon-bundle-length bundle))
          (validate-image (gfg:icon-image-ref bundle 0) happy-size 8)
          (validate-image (gfg:icon-image-ref bundle 1) tc-size 16000000)
          (validate-image (gfg:icon-image-ref bundle 2) bw-size 8)
          (validate-image (gfg:icon-image-ref bundle :small) tc-size 8)
          (validate-image (gfg:icon-image-ref bundle :large) happy-size 8))
      (gfs:dispose bundle))
    (assert-true (gfs:disposed-p bundle))))

(define-test system-icon-bundle-test
  (let ((size (gfs:make-size :width (gfs::get-system-metrics gfs::+sm-cxicon+)
                             :height (gfs::get-system-metrics gfs::+sm-cyicon+)))
        (bundle (make-instance 'gfg:icon-bundle :system gfg:+warning-icon+)))
    (unwind-protect
        (progn
          (assert-equal 1 (gfg:icon-bundle-length bundle))
          (validate-image (gfg:icon-image-ref bundle 0) size 8)
          (validate-image (gfg:icon-image-ref bundle :small) size 8)
          (validate-image (gfg:icon-image-ref bundle :large) size 8))
      (gfs:dispose bundle))
    (assert-true (gfs:disposed-p bundle))))

(define-test setf-images-icon-bundle-test
  (let ((bundle (make-instance 'gfg:icon-bundle
                               :images (list (make-instance 'gfg:image :file (merge-pathnames "uitoolkit/happy.bmp" *gf-tests-dir*))
                                             (make-instance 'gfg:image :file (merge-pathnames "uitoolkit/truecolor16x16.bmp" *gf-tests-dir*)))))
        (happy-image (make-instance 'gfg:image :file (merge-pathnames "uitoolkit/happy.bmp" *gf-tests-dir*)))
        (bw-image (make-instance 'gfg:image :file (merge-pathnames "uitoolkit/blackwhite20x16.bmp" *gf-tests-dir*)))
        (happy-size (gfs:make-size :width 32 :height 32))
        (bw-size (gfs:make-size :width 20 :height 16)))
    (unwind-protect
        (progn
          (assert-equal 2 (gfg:icon-bundle-length bundle))
          (setf (gfg:icon-image-ref bundle 0) bw-image)
          (setf (gfg:icon-image-ref bundle 1) happy-image)
          (assert-equal 2 (gfg:icon-bundle-length bundle))
          (validate-image (gfg:icon-image-ref bundle 0) bw-size 16000000)
          (validate-image (gfg:icon-image-ref bundle 1) happy-size 8))
      (gfs:dispose bundle))
    (assert-true (gfs:disposed-p bundle))))
