# lineno.sty v5.5, fnlineno.sty v0.55

2025/05/13

The LaTeX package lineno.sty provides line numbers on paragraphs.  After TeX has
broken a paragraph into lines there will be line numbers attached to them, with
the possibility to make references through the LaTeX \ref, \pageref cross
reference mechanism.

- Copyright 1995--2003 Stephan I. Böttcher
- Copyright 2002--2005 Uwe Lück for versions 4.x and code from former Ednotes
- Copyright 2011       Uwe Lück for fnlineno.sty/tex/pdf
- Copyright 2021--2025 Karl Wette for versions 5.x

The files can be redistributed and/or modified under
the terms of the LaTeX Project Public License; either
version 1.3a of the License, or any later version.
The latest version of this license is in http://www.latex-project.org/lppl.txt.
We did our best to help you, but there is NO WARRANTY.

Home: http://mirror.ctan.org/macros/latex/contrib/lineno/

Authors:

- Stephan I. Böttcher
- Uwe Lück
- Karl Wette

## Compatibility with other packages:

- `wrapfig.sty`: works since v2.05

- `multicol.sty`: works partly since 3.02.  Do NOT use \linelabel.  Do NOT put a
  multicol in internal vertical mode {table}, {figure}, etc.

- `hyperref.sty`: \ref to a \linelabel works since v3.03.

- `longtable.sty`: broke with lineno.sty loaded, but not enabled.  This is fixed
  in v3.04.

- `amsmath.sty`: loadable, but not fully supported, with v4.41.  Fully supported
  with v5.0. Use LaTeX hooks to allow independent loading of `amsmath` and `lineno`
  with v5.1. Support `amsmath` option `\allowdisplaybreaks` with v5.2.

## Installation and usage (UL, v4.1):

For being able to use ALL the new `lineno.sty` options, the following files must
be "visible" to (La)TeX ("visible" explained below for beginners):

- `lineno.sty`, `edtable.sty`, `ednmath0.sty`, `ltabptch.sty` -- as above
  ("Home", note that clicking on "entire directory" suffices);
- `longtable.sty` -- from the standard LaTeX Tools bundle.

Usage always starts with loading lineno.sty by `\usepackage`.  The remaining
`.sty` files are loaded automatically on the `lineno.sty` options (and we
recommend not to load them through [the mandatory argument of] `\usepackage`).

For details, see `lineno.tex/pdf` and the `.sty` files mentioned above--search
especially for tabular and math mode.  (+ `print` below here).

"Visible to (LaTeX)": Some users don't understand this "visibility" for a while,
and indeed it may be somewhat non-trivial. These users may find help in
https://mirrors.ctan.org/macros/latex/contrib/ednotes/visible.txt . E.g., former users of
lineno.sty may just put all the .sty files into the folder (at their workplace)
where they had placed lineno.sty before.  (/UL, /v4.1)

To print the documented source: Take the style-file `lineno.sty`, and feed it to
a Un*x shell.  (Or download the extracted source documentation `lineno.tex`.)
```
csh> source ./lineno.sty
sh>  . ./lineno.sty
```
[ i.e., type `sh lineno.sty` (e.g.) as a UNIX command line.  Problems with awk
may arise. I therefore switched to nawk in lineno.sty v4.00, but this may
trouble you as well.  (UL) ] (Please ignore the error message at the beginning
about the iffalse.)

## Files

(cf. `SRCFILEs.txt`):

- `README.txt`: This file. (v4.1: UL)
- `CHANGEs.txt`: Differences to previous versions. (v4.1: UL)
- `COPYING.txt`: The LPPL header.
- `SCRFILEs.txt`: Source file infos (UL 2011)
- `lineno.sty`: The package itself, ready to use.
- `edtable.sty`: Module for tabular environments. (UL, v4.1)
- `ednmath0.sty`: Module for \linelabel in math mode. (UL, v4.1)
- `fnlineno.sty`: Add-on for footnote line numbers (UL, v0.55)
- `lineno.tex`: The source for the documentation (generated)
- `lineno.pdf`: PDF deriving from the former. (v4.1: UL)
- `lnosuppl.pdf`: PDF listing of present non-PDF files
- `ulineno.tex`: The pathetic attempt of a users' manual. [Describes v3.1 currently.] (UL, v4.1)
- `ulineno.pdf`: PDF of former.
- `vplref.sty`: Conditionally include page number in line number references (UL, v4.2)
- `linenoamsmathdemo.tex`: Demo of making amsmath work with lineno (KW, v5.0)

As of version v3.00, the extension packages for lineno have all been
incorporated into `lineno.sty` itself.  Except for `itemrule.sty`, which was
removed.

## History

(Prior to my taking over maintenance of the package -- KW)

    ** [ UL: A few festive words on history and responsibility   **
    **       are next preceding hard facts as to (see lower)     **
    **       o `Files'  and                                      **
    **       o `Installation and usage'.                       ] **

    2004-09-13 Uwe Lück  [(UL)]  is new maintainer for lineno.sty.

    lineno.sty served the purpose for which I wrote it years ago.  Uwe
    Lück uses lineno.sty with his Ednotes package, which required quite a
    few changes and fixes.  His package depends on lineno, therefore
    Uwe agreed to take over the maintenance of lineno.sty.

    lineno.sty v4.0 includes most of the well tested changes that Uwe
    needs for Ednotes.  These changes blend well into the concepts of the
    package, so I am happy to let it go.

    From here on it is Uwe's, and he may proceed to mangle it as he likes.
    Expect some radical changes.  You may find him to be quite a bit
    friendlier towards the poor souls who still use Windows :-).
    Currently, you need some kind of Unix environment to extract the
    source documentation from the sty file.

    If some version 3 users run into difficulties with Uwe's newer
    versions, but need a minor bug-fix in version 3, please do not
    hesitate to ask me for help.  But all requests for new features or
    major changes shall go to Uwe.

    Cheers
    Stephan

    [ Thanks!  And please let me know as well should
      compatibility problems arise!  The announced radical
      changes are postponed again this time (v4.1).
      --Ednotes is in
        http://mirror.ctan.org/macros/latex/contrib/ednotes.
                                                       Uwe ]

    Please have a look at a similar work of Michal Jaegermann and James
    Fortune:
             http://mirror.ctan.org/obsolete/macros/latex/contrib/numline/
