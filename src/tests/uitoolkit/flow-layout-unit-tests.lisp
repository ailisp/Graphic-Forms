(in-package :graphic-forms.uitoolkit.tests)

(defvar *flow-uniform-kids* (list (make-instance 'mock-widget :min-size *child-size-2*)
                                  (make-instance 'mock-widget :min-size *child-size-2*)
                                  (make-instance 'mock-widget :min-size *child-size-2*)))
(defvar *flow-mixed-kids* (list (make-instance 'mock-widget :min-size *child-size-2*)
                                (make-instance 'mock-widget :min-size *child-size-1*)
                                (make-instance 'mock-widget :min-size *child-size-2*)))

(define-layout-test flow-layout-test1
                    -1 -1 60 10
                    nil
                    '((0 0 20 10) (20 0 20 10) (40 0 20 10))
                    #'make-flow-layout *flow-uniform-kids* '(:horizontal))

(define-layout-test flow-layout-test2
                    -1 -1 20 30
                    nil
                    '((0 0 20 10) (0 10 20 10) (0 20 20 10))
                    #'make-flow-layout *flow-uniform-kids* '(:vertical))

(define-layout-test flow-layout-test3
                    45 -1 40 20
                    nil
                    '((0 0 20 10) (20 0 20 10) (0 10 20 10))
                    #'make-flow-layout *flow-uniform-kids* '(:horizontal :wrap))

(define-layout-test flow-layout-test4
                    -1 25 40 20
                    nil
                    '((0 0 20 10) (0 10 20 10) (20 0 20 10))
                    #'make-flow-layout *flow-uniform-kids* '(:vertical :wrap))

(define-layout-test flow-layout-test5
                    45 18 40 20
                    nil
                    '((0 0 20 10) (20 0 20 10) (0 10 20 10))
                    #'make-flow-layout *flow-uniform-kids* '(:horizontal :wrap))

(define-layout-test flow-layout-test6
                    30 25 40 20
                    nil
                    '((0 0 20 10) (0 10 20 10) (20 0 20 10))
                    #'make-flow-layout *flow-uniform-kids* '(:vertical :wrap))

(define-layout-test flow-layout-test7
                    -1 -1 68 10
                    nil
                    '((0 0 20 10) (24 0 20 10) (48 0 20 10))
                    #'make-flow-layout *flow-uniform-kids* '(:horizontal) 4)

(define-layout-test flow-layout-test8
                    -1 -1 20 38
                    nil
                    '((0 0 20 10) (0 14 20 10) (0 28 20 10))
                    #'make-flow-layout *flow-uniform-kids* '(:vertical) 4)

(define-layout-test flow-layout-test9
                    45 18 44 24
                    nil
                    '((0 0 20 10) (24 0 20 10) (0 14 20 10))
                    #'make-flow-layout *flow-uniform-kids* '(:horizontal :wrap) 4)

(define-layout-test flow-layout-test10
                    30 25 44 24
                    nil
                    '((0 0 20 10) (0 14 20 10) (24 0 20 10))
                    #'make-flow-layout *flow-uniform-kids* '(:vertical :wrap) 4)

(define-layout-test flow-layout-test11
                    -1 -1 63 13
                    nil
                    '((3 3 20 10) (23 3 20 10) (43 3 20 10))
                    #'make-flow-layout *flow-uniform-kids* '(:horizontal) 0 3 3)

(define-layout-test flow-layout-test12
                    -1 -1 23 33
                    nil
                    '((0 0 20 10) (0 10 20 10) (0 20 20 10))
                    #'make-flow-layout *flow-uniform-kids* '(:vertical) 0 0 0 3 3)

(define-layout-test flow-layout-test13
                    -1 -1 75 10
                    nil
                    '((0 0 25 10) (25 0 25 10) (50 0 25 10))
                    #'make-flow-layout *flow-mixed-kids* '(:horizontal :normalize))

(define-layout-test flow-layout-test14
                    -1 -1 25 30
                    nil
                    '((0 0 25 10) (0 10 25 10) (0 20 25 10))
                    #'make-flow-layout *flow-mixed-kids* '(:vertical :normalize))
