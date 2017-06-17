(in-package :graphic-forms.uitoolkit.system)

(define-condition toolkit-error (simple-error)
  ((detail :reader detail :initarg :detail :initform nil)))

(defmethod print-object ((obj toolkit-error) stream)
  (let ((detail (detail obj)))
    (cond
      (detail
       (format stream "~a" detail))
      (t
       (call-next-method)))))

(define-condition toolkit-warning (simple-warning)
  ((detail :reader detail :initarg :detail :initform nil)))

(defmethod print-object ((obj toolkit-warning) stream)
  (let ((detail (detail obj)))
    (cond
      (detail
       (format stream "~a" detail))
      (t
       (call-next-method)))))

(define-condition disposed-error (error) ())

(define-condition win32-error (toolkit-error)
  ((code :reader code :initarg :code :initform (get-last-error))))

(defmethod print-object ((obj win32-error) stream)
  (format stream "code ~a: ~a" (code obj) (detail obj)))

(define-condition win32-warning (toolkit-warning)
  ((code :reader code :initarg :code :initform (get-last-error))))

(defmethod print-object ((obj win32-warning) stream)
  (format stream "code ~a: ~a" (code obj) (detail obj)))

(define-condition comdlg-error (win32-error)
  ((dlg-code :reader dlg-code :initarg :dlg-code :initform (comm-dlg-extended-error))))

(defmethod print-object ((obj comdlg-error) stream)
  (format stream "common dialog code ~a: ~a" (code obj) (detail obj)))
