(terpri)
(format t "Graphic-Forms UI Toolkit~%")
(format t "Copyright (c) 2006-2007 by Jack D. Unrue~%")
(format t "Copyright (C) 2016 by Bo Yao <icerove@gmail.com>~%")
(terpri)

(defsystem graphic-forms
  :description "Graphic-Forms UI Toolkit"
  :version "0.9.0"
  :author "Jack D. Unrue"
  :maintainer "Bo Yao <icerove@gmail.com>"
  :licence "BSD"
  :depends-on ("graphic-forms-uitoolkit"
	       "graphic-forms-tests"))
