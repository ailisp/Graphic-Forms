(in-package :graphic-forms.uitoolkit.tests)

(defun image-data-tester (path)
  (let ((d1 (make-instance 'gfg:image-data))
        (d2 nil)
        (d3 nil)
        (im (make-instance 'gfg:image))
        (hbmp (cffi:null-pointer)))
    (unwind-protect
        (progn
          (gfg:load d1 path)
          (cffi:with-foreign-string (ptr path)
            (setf hbmp (gfs::load-image nil
                                        ptr
                                        gfs::+image-bitmap+
                                        0 0
                                        (logior gfs::+lr-loadfromfile+
                                                gfs::+lr-createdibsection+))))
          (if (gfs:null-handle-p hbmp)
            (error 'gfs:win32-error :detail "load-image failed"))
          (setf d2 (gfg::image->data hbmp))
          (assert-equal (gfg:depth d1) (gfg:depth d2) path)
          (let ((size1 (gfg:size d1))
                (size2 (gfg:size d2)))
            (assert-equal (gfs:size-width size1) (gfs:size-width size2) path)
            (assert-equal (gfs:size-height size1) (gfs:size-height size2) path))
          (gfg:load im path)
          (setf d3 (gfg:data-object im))
          (assert-equal (gfg:depth d1) (gfg:depth d3) path)
          (let ((size1 (gfg:size d1))
                (size2 (gfg:size d3)))
            (assert-equal (gfs:size-width size1) (gfs:size-width size2) path)
            (assert-equal (gfs:size-height size1) (gfs:size-height size2) path))
      (unless (gfs:disposed-p im)
        (gfs:dispose im))
      (unless (gfs:null-handle-p hbmp)
        (gfs::delete-object hbmp))))))

#|
(define-test image-data-loading-test
  (mapc #'image-data-tester '("blackwhite20x16.bmp" "happy.bmp" "truecolor16x16.bmp")))
|#
