(in-package :graphic-forms.uitoolkit.widgets)

;;;
;;; helper functions
;;;

(defun get-menuitem-state (hmenu mid)
  (cffi:with-foreign-object (mii-ptr '(:struct gfs::menuiteminfo))
    (cffi:with-foreign-slots ((gfs::cbsize gfs::mask gfs::type
                               gfs::state gfs::id gfs::hsubmenu
                               gfs::hbmpchecked gfs::hbmpunchecked
                               gfs::idata gfs::tdata gfs::cch
                               gfs::hbmpitem)
                              mii-ptr (:struct gfs::menuiteminfo))
      (setf gfs::cbsize (cffi:foreign-type-size '(:struct gfs::menuiteminfo)))
      (setf gfs::mask (logior gfs::+miim-id+ gfs::+miim-state+))
      (setf gfs::type 0)
      (setf gfs::state 0)
      (setf gfs::id mid)
      (setf gfs::hsubmenu (cffi:null-pointer))
      (setf gfs::hbmpchecked (cffi:null-pointer))
      (setf gfs::hbmpunchecked (cffi:null-pointer))
      (setf gfs::idata 0)
      (setf gfs::tdata (cffi:null-pointer))
      (setf gfs::cch 0)
      (setf gfs::hbmpitem (cffi:null-pointer))
      (if (zerop (gfs::get-menu-item-info hmenu mid 0 mii-ptr))
        (error 'gfs:win32-error :detail "get-menu-item-info failed"))
      gfs::state)))

(defun get-menuitem-text (hmenu mid)
  (cffi:with-foreign-object (mii-ptr '(:struct gfs::menuiteminfo))
    (cffi:with-foreign-slots ((gfs::cbsize gfs::mask gfs::type
                               gfs::state gfs::id gfs::hsubmenu
                               gfs::hbmpchecked gfs::hbmpunchecked
                               gfs::idata gfs::tdata gfs::cch
                               gfs::hbmpitem)
                              mii-ptr (:struct gfs::menuiteminfo))
      (setf gfs::cbsize (cffi:foreign-type-size '(:struct gfs::menuiteminfo)))
      (setf gfs::mask (logior gfs::+miim-id+ gfs::+miim-string+))
      (setf gfs::type 0)
      (setf gfs::state 0)
      (setf gfs::id mid)
      (setf gfs::hsubmenu (cffi:null-pointer))
      (setf gfs::hbmpchecked (cffi:null-pointer))
      (setf gfs::hbmpunchecked (cffi:null-pointer))
      (setf gfs::idata 0)
      (setf gfs::tdata (cffi:null-pointer))
      (setf gfs::cch 0)
      (setf gfs::hbmpitem (cffi:null-pointer))
      (if (zerop (gfs::get-menu-item-info hmenu mid 0 mii-ptr))
        (error 'gfs:win32-error :detail "get-menu-item-info failed"))
      (incf gfs::cch)
      (let ((str-ptr (cffi:foreign-alloc :char :count gfs::cch))
            (result ""))
        (unwind-protect
            (progn
              (setf gfs::tdata str-ptr)
              (if (zerop (gfs::get-menu-item-info hmenu mid 0 mii-ptr))
                (error 'gfs:win32-error :detail "get-menu-item-info failed"))
              (setf result (cffi:foreign-string-to-lisp str-ptr))
          (cffi:foreign-free str-ptr)))
        result))))

(defun set-menuitem-text (hmenu mid label)
  (cffi:with-foreign-string (str-ptr label)
    (cffi:with-foreign-object (mii-ptr '(:struct gfs::menuiteminfo))
      (cffi:with-foreign-slots ((gfs::cbsize gfs::mask gfs::type
                                 gfs::state gfs::id gfs::hsubmenu
                                 gfs::hbmpchecked gfs::hbmpunchecked
                                 gfs::idata gfs::tdata gfs::cch
                                 gfs::hbmpitem)
                                mii-ptr (:struct gfs::menuiteminfo))
        (setf gfs::cbsize (cffi:foreign-type-size '(:struct gfs::menuiteminfo)))
        (setf gfs::mask (logior gfs::+miim-id+ gfs::+miim-string+))
        (setf gfs::type 0)
        (setf gfs::state 0)
        (setf gfs::id mid)
        (setf gfs::hsubmenu (cffi:null-pointer))
        (setf gfs::hbmpchecked (cffi:null-pointer))
        (setf gfs::hbmpunchecked (cffi:null-pointer))
        (setf gfs::idata 0)
        (setf gfs::tdata str-ptr)
        (setf gfs::cch (length label))
        (setf gfs::hbmpitem (cffi:null-pointer)))
      (if (zerop (gfs::set-menu-item-info hmenu mid 0 mii-ptr))
        (error 'gfs:win32-error :detail "set-menu-item-info failed")))))

(defun check-menuitem (hmenu mid checked)
  (cffi:with-foreign-object (mii-ptr '(:struct gfs::menuiteminfo))
    (cffi:with-foreign-slots ((gfs::cbsize gfs::mask gfs::type
                               gfs::state gfs::id gfs::hsubmenu
                               gfs::hbmpchecked gfs::hbmpunchecked
                               gfs::idata gfs::tdata gfs::cch
                               gfs::hbmpitem)
                              mii-ptr  (:struct gfs::menuiteminfo))
      (setf gfs::cbsize (cffi:foreign-type-size '(:struct gfs::menuiteminfo)))
      (setf gfs::mask (logior gfs::+miim-id+ gfs::+miim-state+))
      (setf gfs::type 0)
      (setf gfs::state (if checked gfs::+mfs-checked+ gfs::+mfs-unchecked+))
      (setf gfs::id mid)
      (setf gfs::hsubmenu (cffi:null-pointer))
      (setf gfs::hbmpchecked (cffi:null-pointer))
      (setf gfs::hbmpunchecked (cffi:null-pointer))
      (setf gfs::idata 0)
      (setf gfs::tdata (cffi:null-pointer))
      (setf gfs::cch 0)
      (setf gfs::hbmpitem (cffi:null-pointer)))
    (if (zerop (gfs::set-menu-item-info hmenu mid 0 mii-ptr))
      (error 'gfs:win32-error :detail "set-menu-item-info failed"))))

(defun is-menuitem-checked (hmenu mid)
  (cffi:with-foreign-object (mii-ptr '(:struct gfs::menuiteminfo))
    (cffi:with-foreign-slots ((gfs::cbsize gfs::mask gfs::type
                               gfs::state gfs::id gfs::hsubmenu
                               gfs::hbmpchecked gfs::hbmpunchecked
                               gfs::idata gfs::tdata gfs::cch
                               gfs::hbmpitem)
                              mii-ptr (:struct gfs::menuiteminfo))
      (setf gfs::cbsize (cffi:foreign-type-size '(:struct gfs::menuiteminfo)))
      (setf gfs::mask (logior gfs::+miim-id+ gfs::+miim-state+))
      (setf gfs::type 0)
      (setf gfs::state 0)
      (setf gfs::id mid)
      (setf gfs::hsubmenu (cffi:null-pointer))
      (setf gfs::hbmpchecked (cffi:null-pointer))
      (setf gfs::hbmpunchecked (cffi:null-pointer))
      (setf gfs::idata 0)
      (setf gfs::tdata (cffi:null-pointer))
      (setf gfs::cch 0)
      (setf gfs::hbmpitem (cffi:null-pointer))
      (if (zerop (gfs::get-menu-item-info hmenu mid 0 mii-ptr))
        (error 'gfs:win32-error :detail "set-menu-item-info failed"))
      (= (logand gfs::state gfs::+mfs-checked+) gfs::+mfs-checked+))))

;;;
;;; methods
;;;

(defmethod check ((self menu-item) flag)
  (let ((hmenu (gfs:handle self)))
    (check-menuitem hmenu (item-id self) flag)))

(defmethod checked-p ((self menu-item))
  (let ((hmenu (gfs:handle self)))
    (if (gfs:null-handle-p hmenu)
      (error 'gfs:toolkit-error :detail "null owner menu handle"))
    (is-menuitem-checked hmenu (item-id self))))

(defmethod gfs:dispose ((self menu-item))
  (let ((id (item-id self))
        (owner (owner self)))
    (unless (null owner)
      (gfs::remove-menu (gfs:handle owner) id gfs::+mf-bycommand+)
      (let* ((index (item-index owner self))
             (child-menu (sub-menu owner index)))
        (unless (null child-menu)
          (gfs:dispose child-menu)))))
  (call-next-method))

(defmethod enable ((self menu-item) flag)
  (let ((bits 0))
    (if flag
      (setf bits (logior gfs::+mf-bycommand+ gfs::+mfs-enabled+))
      (setf bits (logior gfs::+mf-bycommand+ gfs::+mfs-grayed+)))
    (gfs::enable-menu-item (gfs:handle self) (item-id self) bits)))

(defmethod enabled-p ((self menu-item))
  (= (logand (get-menuitem-state (gfs:handle self) (item-id self))
             gfs::+mfs-enabled+)
     gfs::+mfs-enabled+))

(defmethod text ((self menu-item))
  (let ((hmenu (gfs:handle self)))
    (if (gfs:null-handle-p hmenu)
      (error 'gfs:toolkit-error :detail "null owner menu handle"))
    (get-menuitem-text hmenu (item-id self))))

(defmethod (setf text) (str (self menu-item))
  (let ((hmenu (gfs:handle self)))
    (if (gfs:null-handle-p hmenu)
      (error 'gfs:toolkit-error :detail "null owner menu handle"))
    (set-menuitem-text hmenu (item-id self) str)))
