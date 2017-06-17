(in-package :graphic-forms.uitoolkit.widgets)

;;;
;;; helper functions
;;;

(defun lb-insert-item (hwnd index label hbmp)
  (declare (ignore hbmp)) ; FIXME: re-enable when we support images in list-box
  (let ((text (or label "")))
    (cffi:with-foreign-string (str-ptr text)
      (let ((retval (gfs::send-message hwnd gfs::+lb-insertstring+ index (cffi:pointer-address str-ptr))))
        (if (< retval 0)
          (error 'gfs:toolkit-error :detail (format nil "LB_INSERTSTRING failed: ~d" retval)))))))

(defun lb-item-height (hwnd)
  (let ((height (gfs::send-message hwnd gfs::+lb-getitemheight+ 0 0)))
    (if (< height 0)
      (error 'gfs:win32-error :detail "LB_GETITEMHEIGHT failed"))
    height))

(defun lb-item-text-length (hwnd index)
  (let ((length (gfs::send-message hwnd gfs::+lb-gettextlen+ index 0)))
    (if (< length 0)
      (error 'gfs:win32-error :detail "LB_GETTEXTLEN failed"))
    length))

(defun lb-item-text (hwnd index &optional buffer-size)
  (if (or (null buffer-size) (<= buffer-size 0))
    (setf buffer-size (lb-item-text-length hwnd index)))
  (cffi:with-foreign-pointer-as-string (str-ptr (1+ buffer-size))
    (if (< (gfs::send-message hwnd gfs::+lb-gettext+ index (cffi:pointer-address str-ptr)) 0)
      (error 'gfs:win32-error :detail "LB_GETTEXT failed"))
    (cffi:foreign-string-to-lisp str-ptr)))

;;;
;;; methods
;;;

(defmethod gfs:dispose ((self list-item))
  (let ((hwnd (gfs:handle self)))
    (unless (or (null hwnd) (cffi:null-pointer-p hwnd))
      (let ((owner (get-widget (thread-context) hwnd)))
        (if (and owner (cffi:pointer-eq hwnd (gfs:handle owner)))
          (gfs::send-message hwnd gfs::+lb-deletestring+ (item-index owner self) 0)))))
  (call-next-method))

(defmethod select ((self list-item) flag)
  (let ((owner (owner self)))
    (if flag
      (lb-select-item owner (item-index owner self))
      (lb-deselect-item owner (item-index owner self)))))

(defmethod selected-p ((self list-item))
  (let ((owner (owner self)))
    (> (gfs::send-message (gfs:handle self) gfs::+lb-getsel+ (item-index owner self) 0) 0)))

(defmethod text ((self list-item))
  (let ((hwnd (gfs:handle self)))
    (if (or (null hwnd) (cffi:null-pointer-p hwnd))
      ""
      (lb-item-text hwnd (item-index (get-widget (thread-context) hwnd) self)))))
