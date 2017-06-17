(in-package :graphic-forms.uitoolkit.tests)

(defvar *all-border-kids* (list (make-instance 'mock-widget :min-size *child-size-1*)   ; top
                                (make-instance 'mock-widget :min-size *child-size-2*)   ; right
                                (make-instance 'mock-widget :min-size *child-size-1*)   ; bottom
                                (make-instance 'mock-widget :min-size *child-size-2*)   ; left
                                (make-instance 'mock-widget :min-size *child-size-3*))) ; center

(defvar *outer-border-kids* (list (make-instance 'mock-widget :min-size *child-size-1*) ; top
                                  (make-instance 'mock-widget :min-size *child-size-2*) ; right
                                  (make-instance 'mock-widget :min-size *child-size-1*) ; bottom
                                  (make-instance 'mock-widget :min-size *child-size-2*) ; left
                                  nil))

(defvar *top-right-border-kids* (list (make-instance 'mock-widget :min-size *child-size-1*) ; top
                                      (make-instance 'mock-widget :min-size *child-size-2*) ; right
                                      nil nil nil))

(defvar *top-bottom-border-kids* (list (make-instance 'mock-widget :min-size *child-size-1*) ; top
                                       nil
                                       (make-instance 'mock-widget :min-size *child-size-1*) ; bottom
                                       nil nil))

(defvar *center-border-kid* (list nil nil nil nil
                                  (make-instance 'mock-widget :min-size *child-size-3*)))

;;;
;;; NOTE: the rects to be validated in each test must be specified in the
;;; the following order: center, top, left, bottom, right
;;;

(define-layout-test border-layout-test1
                    -1 -1 80 50
                    nil
                    '((20 5 40 40) (0 0 80 5) (0 5 20 40) (0 45 80 5) (60 5 20 40))
                    #'make-border-layout *all-border-kids*)

(define-layout-test border-layout-test2
                    -1 -1 40 20
                    nil
                    '((0 0 40 5) (0 5 20 10) (0 15 40 5) (20 5 20 10))
                    #'make-border-layout *outer-border-kids*)

(define-layout-test border-layout-test3
                    -1 -1 40 40
                    nil
                    '((0 0 40 40))
                    #'make-border-layout *center-border-kid*)

(define-layout-test border-layout-test4
                    -1 -1 25 15
                    nil
                    '((0 0 25 5) (0 5 20 10))
                    #'make-border-layout *top-right-border-kids*)

(define-layout-test border-layout-test5
                    -1 -1 25 10
                    nil
                    '((0 0 25 5) (0 5 25 5))
                    #'make-border-layout *top-bottom-border-kids*)

(define-layout-test border-layout-test6
                    26 -1 26 50
                    nil
                    '((6 5 13 40) (0 0 26 5) (0 5 6 40) (0 45 26 5) (19 5 6 40))
                    #'make-border-layout *all-border-kids*)

(define-layout-test border-layout-test7
                    -1 -1 90 58
                    nil
                    '((24 8 40 40) (4 3 80 5) (4 8 20 40) (4 48 80 5) (64 8 20 40))
                    #'make-border-layout *all-border-kids* 4 3 6 5)

(defun border-layout-spacing (layout)
  (loop for pair in (gfw::data-of layout)
        for widget = (first pair)
        for key = (first (second pair))
        do (case key
             ;; note - we leave :center region with default spacing
             (:top    (setf (gfw:layout-attribute layout widget :leading-spacing) 2))
             (:left   (setf (gfw:layout-attribute layout widget :trailing-spacing) 3))
             (:right  (setf (gfw:layout-attribute layout widget :spacing) 4))
             (:bottom (setf (gfw:layout-attribute layout widget :center-spacing) 5)))))

(define-layout-test border-layout-test8
                    -1 -1 80 50
                    #'border-layout-spacing
                    '((20 5 40 40) (0 0 80 5) (0 5 20 40) (0 45 80 5) (60 5 20 40))
                    #'make-border-layout *all-border-kids*)
