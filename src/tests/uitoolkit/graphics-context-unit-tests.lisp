(in-package :graphic-forms.uitoolkit.tests)

(define-test pen-styles-test
  (let ((style1 nil)
        (style2 '(:solid))
        (style3 '(:dash :flat-endcap))
        (style4 '(:dot :miter-join))
        (style5 '(:alternate :flat-endcap :bevel-join)))
    (dotimes (width 3)
      (assert-equal (logior gfs::+ps-cosmetic+
                            gfs::+ps-null+)
                    (gfg::compute-pen-style style1 width)
                    (list style1 width))
      (assert-equal (logior (if (< width 2) gfs::+ps-cosmetic+ gfs::+ps-geometric+)
                            gfs::+ps-solid+)
                    (gfg::compute-pen-style style2 width)
                    (list style2 width))
      (assert-equal (logior gfs::+ps-geometric+
                            gfs::+ps-dash+
                            gfs::+ps-endcap-flat+)
                    (gfg::compute-pen-style style3 width)
                    (list style3 width))
      (assert-equal (logior gfs::+ps-geometric+
                            gfs::+ps-dot+
                            gfs::+ps-join-miter+)
                    (gfg::compute-pen-style style4 width)
                    (list style4 width))
      (assert-equal (logior gfs::+ps-geometric+
                            gfs::+ps-alternate+
                            gfs::+ps-endcap-flat+
                            gfs::+ps-join-bevel+)
                    (gfg::compute-pen-style style5 width)
                    (list style5 width)))))
