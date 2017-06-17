(in-package :graphic-forms.uitoolkit.tests)

(define-test color-conversion-test
  (let ((c1 (gfg:make-color))
        (c2 (gfg:make-color :red 12 :green 34 :blue 56))
        (c3 (gfg:make-color :red 255 :green 128 :blue 0))
        (c4 (gfg:make-color :red 255 :green 255 :blue 255)))
    (loop for clr in (list c1 c2 c3 c4)
          do (let ((rgb (gfg::color->rgb clr)))
               (assert-equal (gfg:color-red clr) (gfg:color-red (gfg::rgb->color rgb)))
               (assert-equal (gfg:color-green clr) (gfg:color-green (gfg::rgb->color rgb)))
               (assert-equal (gfg:color-blue clr) (gfg:color-blue (gfg::rgb->color rgb)))))))
