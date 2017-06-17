(in-package :graphic-forms.uitoolkit.system)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (use-package :cffi))

(load-foreign-library "comdlg32.dll")

(defcfun
  ("ChooseColorA" choose-color)
  BOOL
  (struct LPTR)) ; choosecolor struct

(defcfun
  ("ChooseFontA" choose-font)
  BOOL
  (struct LPTR)) ; choosefont struct

(defcfun
  ("CommDlgExtendedError" comm-dlg-extended-error)
  DWORD)

(defcfun
  ("FindTextA" find-text)
  HANDLE
  (fr LPTR)) ; findreplace struct

(defcfun
  ("GetOpenFileNameA" get-open-filename)
  BOOL
  (ofn LPTR)) ; openfilename struct

(defcfun
  ("GetSaveFileNameA" get-save-filename)
  BOOL
  (ofn LPTR)) ; openfilename struct

(defcfun
  ("ReplaceTextA" replace-text)
  HANDLE
  (fr LPTR)) ; findreplace struct
