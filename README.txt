
Graphic-Forms README for version 0.9.0
--------------------------------------

Copyright (c) 2006-2007, Jack D. Unrue Copyright (c) 2016, Bo Yao

Graphic-Forms is a user interface library implemented in Common Lisp
focusing on the Windows(R) platform. Graphic-Forms is licensed under
the terms of the BSD License.

This is a fork of original Graphic-Forms in common-lisp.net, which was
not maintained. I decide to fix this to work under new verison of
Windows and can be loaded through quicklisp, then use it as backend so
McCLIM can run on Windows again (There was a McCLIM backend
Graphic-Forms, but it didn't work and had been removed from newest
McCLIM). I will then seperately maintain this McCLIM backend
separately until it's mature and stable enough to merge into
McCLIM. By then, McCLIM will be able to run on Linux, Mac OS X and
Windows. Graphic-Forms will always suitable for simply, Windows only
programs in Common Lisp. Currently Lisp packages are highly obtainable
via QuickLisp, and all Graphic-Forms' dependencies are available via
QuickLisp. Some of its dependencies has been updated. This fork fix
these update issues and Graphic-Forms can now run on Windows again.

Quickstart
----------

Download or clone the project and put it tnto QuickLisp's local
project directory and evaluate: (ql:quickload :graphic-forms)

Dependencies
------------

Graphic-Forms requires the following libraries. When load
Graphic-Forms, all of them can be loaded automatically via QuickLisp.

 - ASDF https://common-lisp.net/project/asdf/

 - CFFI http://common-lisp.net/project/cffi/

 - Closer to MOP http://common-lisp.net/project/closer/

 - lw-compat https://github.com/pcostanza/lw-compat

 - Practical Common Lisp Chapter08 and Chapter24
   https://github.com/gigamonkey/monkeylib-macro-utilities
   https://github.com/gigamonkey/monkeylib-binary-data

To run tests, you need:

 - lisp-unit https://github.com/OdonataResearchLLC/lisp-unit

The following libraries are optional:

 - ImageMagick 6.2.6.5-Q16
   http://www.imagemagick.org/download/binaries/ImageMagick-6.2.6-5-Q16-windows-dll.exe


Supported Common Lisp Implementations
-------------------------------------

Graphic-Forms currently supports SBCL 1.3.9, CCL 1.11 on Windows 7
x86. Older version of SBCL, CCL, CLisp with x64 version of Windows 7
and other Windows versions should also work, but not tested yet. Tests
on other implementations and different version of Windows are
welcomed. Original Graphic-Forms has Allegro CL and Lispworks support,
but I am not able to test on commercial platforms.

Known Problems
--------------

Aside from the fact that there are a myriad of classes, functions, and
features in general that are not yet implemented, this section lists
known problems in this release:

1. The following bug filed against CLISP 2.38

   http://sourceforge.net/tracker/index.php?func=detail&aid=1463994&group_id=1355&atid=101355

   may result in a GPF if a window's layout manager is
   changed. Compared to prior releases of Graphic-Forms, there is much
   less chance of this problem affecting layout management.

2. Please be advised that SBCL is itself still in the early stages of
supporting Windows, and as a consequence, you may experience problems
such as 'GC invariant lost' errors that result in a crash to LDB.

3. The 'unblocked' and 'textedit' demo programs are not yet complete.

4. The gfg:text-extent method currently does not return the correct
text height value. As a workaround, get the text metrics for the font
and compute height from that. The gfg:text-extent function does return
the correct width.

5. If a Graphic-Forms application is launched from within SLIME with
CLISP or SBCL as the backend (both of which are single-threaded on
Win32), further SLIME commands will be 'pipelined' until the
Graphic-Forms main message loop exits. If/when these implementations
gain multi-threading support on Win32, then the Graphic-Forms library
code will be updated to launch a separate thread, as is currently done
for Allegro and LispWorks.


Detailed Instruction on Installation
------------------------------------

1. [OPTIONAL] Install ImageMagick 6.2.6.5-Q16 (note in particular that
it is the Q16 version that is needed, not the Q8 version). The default
installation directory is "c:/Program Files/ImageMagick-6.2.6-Q16/".

2. Download or clone the project and put Graphic-Forms to a QuickLisp
local project directory (Hopefully it will be add to QuickLisp's
Package Index next month.

2. Execute the following forms at your REPL: (ql:quickload
:graphic-forms)

2. If you want more image type support with ImageMagick, Execute the
following forms at your REPL

  (push :load-imagemagick-plugin *features*) (setf
  cl-user::*magick-library-directory* "c:/path/to/ImageMagick/")

3. Execute the following forms at your REPL: (ql:quickload
:graphic-forms)

4. Proceed to the next section to run the tests, or start coding!


How To Run Tests And Demos
--------------------------

1. Load the graphic-forms system as described in the previous section

2. Execute the following forms from your REPL:

  ;; execute demos and test programs (gft:hello-world)

  (gft:unblocked)

  (gft:textedit)

  ;; see src/tests/uitoolkit/README.txt for details on other test
     programs

  ;; execute the unit-tests (in-package :gft) (run-tests)


Feedback and Bug Reports
------------------------

Graphic-Forms project is currently hosted on common-lisp.net, please
provide feedback via the following channels:

The issue tracking system:
https://gitlab.common-lisp.net/byao/Graphic-Forms/issues

If you want to contribute, feel free to send a pull request:
https://gitlab.common-lisp.net/byao/Graphic-Forms/merge_requests

[the end]
