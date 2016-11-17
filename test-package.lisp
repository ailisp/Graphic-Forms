;;;;
;;;; config-test.lisp
;;;;
;;;; Copyright (C) 2016, Bo Yao <icerove@gmail.com>
;;;; All rights reserved.
;;;;
;;;; Redistribution and use in source and binary forms, with or without
;;;; modification, are permitted provided that the following conditions
;;;; are met:
;;;; 
;;;;     1. Redistributions of source code must retain the above copyright
;;;;        notice, this list of conditions and the following disclaimer.
;;;; 
;;;;     2. Redistributions in binary form must reproduce the above copyright
;;;;        notice, this list of conditions and the following disclaimer in the
;;;;        documentation and/or other materials provided with the distribution.
;;;; 
;;;;     3. Neither the names of the authors nor the names of its contributors
;;;;        may be used to endorse or promote products derived from this software
;;;;        without specific prior written permission.
;;;; 
;;;; THIS SOFTWARE IS PROVIDED BY THE AUTHORS AND CONTRIBUTORS "AS IS" AND ANY
;;;; EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
;;;; WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DIS-
;;;; CLAIMED.  IN NO EVENT SHALL THE AUTHORS AND CONTRIBUTORS BE LIABLE FOR ANY
;;;; DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
;;;; (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
;;;; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
;;;; ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;;;; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
;;;; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;;;;
(in-package :cl-user)

(defpackage #:graphic-forms.uitoolkit.tests
  (:nicknames #:gft)
  (:use :common-lisp :lisp-unit)
  (:export
   #:drawing-tester
   #:event-tester
   #:hello-world
   #:image-tester
   #:layout-tester
   #:scroll-tester
   #:widget-tester
   #:textedit
   #:unblocked
   #:windlg))

(in-package #:gft)

(defvar *gf-dir*              (asdf:system-source-directory "graphic-forms-uitoolkit"))
(defvar *gf-tests-dir*        (merge-pathnames "src/tests/" *gf-dir*))
(defvar *textedit-dir*        (merge-pathnames "src/demos/textedit/" *gf-dir*))
(defvar *unblocked-dir*       (merge-pathnames "src/demos/unblocked/" *gf-dir*))


