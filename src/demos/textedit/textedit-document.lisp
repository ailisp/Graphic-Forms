(in-package :graphic-forms.uitoolkit.tests)

(defclass textedit-document ()
  ((content-modified
    :accessor content-modified-of
    :initform nil)
   (file-path
    :accessor file-path-of
    :initform nil)))

(defvar *textedit-model* (make-instance 'textedit-document))

(defun load-textedit-doc (path)
  (let ((buffer ""))
    (with-open-file (input path)
      (do ((line (read-line input nil)
                 (read-line input nil)))
          ((null line))
        (if (zerop (length line))
          (setf buffer (concatenate 'string buffer (format nil "~c~c" #\Return #\Newline)))
          (setf buffer (concatenate 'string buffer (format nil "~a~c~c" line #\Return #\Newline))))))
    buffer))

(defun save-textedit-doc (path buffer)
  (with-open-file (output path :direction :output :if-exists :supersede)
    (format output buffer)))
