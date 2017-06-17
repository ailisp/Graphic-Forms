(in-package :graphic-forms.uitoolkit.system)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (use-package :cffi))

(load-foreign-library "kernel32.dll")

(defcfun
    "Beep"
    BOOL
  (dw-freq DWORD)
  (dw-duration DWORD))

(defcfun
  ("FreeLibrary" free-library)
  BOOL
  (hmodule HANDLE))

(defcfun
  ("GetLastError" get-last-error)
  DWORD)

(defcfun
  ("GetModuleHandleA" get-module-handle)
  HANDLE
  (module-name LPTSTR))

(defcfun
  ("GetProcAddress" get-proc-address)
  :pointer
  (hmodule   HANDLE)
  (proc-name LPTSTR))

(defcfun
  ("LoadLibraryExA" load-library)
  HANDLE
  (file-name LPTSTR)
  (hfile     HANDLE) ; currently reserved and must be a NULL pointer
  (flags     DWORD))

