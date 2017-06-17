(in-package :graphic-forms.uitoolkit.tests)

(defvar *child-size-1* (gfs:make-size :width 25 :height 5))
(defvar *child-size-2* (gfs:make-size :width 20 :height 10))
(defvar *child-size-3* (gfs:make-size :width 40 :height 40))

(defun make-flow-layout (kids style &optional spacing left-margin top-margin right-margin bottom-margin)
  (let ((layout (make-instance 'gfw:flow-layout
                               :style         style
                               :spacing       (or spacing       0)
                               :left-margin   (or left-margin   0)
                               :top-margin    (or top-margin    0)
                               :right-margin  (or right-margin  0)
                               :bottom-margin (or bottom-margin 0))))
    (loop for kid in kids do (gfw::append-layout-item layout kid))
    layout))

(defun make-border-layout (kids &optional left-margin top-margin right-margin bottom-margin)
  (let ((layout (make-instance 'gfw:border-layout
                               :left-margin   (or left-margin   0)
                               :top-margin    (or top-margin    0)
                               :right-margin  (or right-margin  0)
                               :bottom-margin (or bottom-margin 0))))
    (loop for kid in kids
          for region in '(:top :right :bottom :left :center)
          when kid
          do (progn
               (gfw::append-layout-item layout kid)
               (setf (gfw:layout-attribute layout kid region) t)))
    layout))

(defun validate-image (image expected-size expected-depth)
  (declare (ignore expected-depth))
  (assert-false (null image))
  (assert-false (gfs:disposed-p image))
  ;; (assert-equal expected-depth (gfg:depth image))  ; FIXME: image->data needed
  (assert-equality #'gfs:equal-size-p expected-size (gfg:size image)))

(defun validate-rects (entries expected-rects)
  (assert-equal (length expected-rects) (length entries))
  (let ((actual-rects (loop for entry in entries collect (cdr entry))))
    (mapc #'(lambda (expected actual)
              (let ((pnt-a (gfs:location actual))
                    (sz-a (gfs:size actual)))
                (assert-equal (first expected) (gfs:point-x pnt-a))
                (assert-equal (second expected) (gfs:point-y pnt-a))
                (assert-equal (third expected) (gfs:size-width sz-a))
                (assert-equal (fourth expected) (gfs:size-height sz-a))))
          expected-rects
          actual-rects)))

(defmacro define-layout-test (name width-hint height-hint
                              expected-width expected-height
                              customizer expected-rects
                              factory &rest factory-args)
  (let ((layout (gensym))
        (size (gensym))
        (dummy (gensym))
        (data (gensym)))
   `(define-test ,name
      (let* ((,layout (apply ,factory (list ,@factory-args)))
             (,dummy (if ,customizer (funcall ,customizer ,layout)))
             (,size (gfw::compute-size ,layout *mock-container* ,width-hint ,height-hint))
             (,data (gfw::compute-layout ,layout *mock-container* ,width-hint ,height-hint)))
	(declare (ignore ,dummy))
        (assert-equal ,expected-width (gfs::size-width ,size))
        (assert-equal ,expected-height (gfs::size-height ,size))
        (validate-rects ,data ,expected-rects)))))
