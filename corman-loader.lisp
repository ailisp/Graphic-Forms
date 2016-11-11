;;;;
;;;; corman-loader.lisp
;;;; Copyright (c) 2006, Jack D. Unrue
;;;;
;;;; This is a temporary band-aid for the Corman Lisp port while I
;;;; work through porting issues, including problems using the latest
;;;; CVS version of ASDF.
;;;;

(defvar *file-ext* ".lisp")

(defun load-source (lib-name basedir list)
  (print "Loading " lib-name "...")
  (loop for path in list
        do (load (concatenate 'string basedir path *file-ext*)))
  (format t "done.~%"))

;;; lw-compat
;;;
(load-source "lw-compat"
             "c:/projects/third_party/asdf-repo/lw-compat/" 
            '("lw-compat-package" "lw-compat"))

;;; CFFI
;;;
(load-source "CFFI"
             "c:/projects/third_party/asdf-repo/cffi-060925/src/"
             '("utils" "features" "package" "cffi-corman" "libraries"
               "early-types" "types" "enum" "strings" "functions"
               "foreign-vars"))

;;; Graphic-Forms UI Toolkit
;;;
(load-source "GF packages file" "c:/projects/public/graphic-forms/src/" '("packages"))
(load-source "GFS"
             "c:/projects/public/graphic-forms/src/uitoolkit/system/"
             '("system-constants" "system-classes" "system-conditions"
               "system-generics" "system-types" "datastructs" "clib"
               "comdlg32" "comctl32" "gdi32" "kernel32" "user32"
               "metrics" "native-object" "system-utils"))
