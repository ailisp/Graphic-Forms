;;; -*- Mode: Lisp -*-

;;;;
;;;; graphic-forms.asd
;;;;
;;;; Copyright (C) 2006-2007, Jack D. Unrue
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

(print "Graphic-Forms UI Toolkit")
(print "Copyright (c) 2006-2007 by Jack D. Unrue")
(print "Copyright (C) 2016 by Bo Yao <icerove@gmail.com>")
(print " ")

(defsystem graphic-forms
  :description "Graphic-Forms UI Toolkit"
  :version "0.9.0"
  :author "Jack D. Unrue"
  :maintainer "Bo Yao <icerove@gmail.com>"
  :licence "BSD"
  :depends-on ("graphic-forms-uitoolkit"
	       "graphic-forms-tests"))
