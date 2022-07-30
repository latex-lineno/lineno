LATEX = latex -interaction=nonstopmode
DVIPDF = dvipdf
TAR = tar

PDFS = fnlineno.pdf lineno.pdf lnosuppl.pdf ulineno.pdf
PKGS = ednmath0.sty edtable.sty fnlineno.sty lineno.sty vplref.sty
TXTS = CHANGEs.txt COPYING.txt README.txt SRCFILEs.txt

TARBALL = lineno.tds.tar.gz
TARDIRS = 's|^|latex/lineno/|;s|^\(.*\.pdf\)|doc/\1|;s|^\(.*\.sty\)|tex/\1|;s|^\(.*\.tex\)|source/\1|;s|^\(.*\.txt\)|doc/\1|'

.PHONY: all

all: $(TARBALL)

lineno.tex: lineno.sty
	sh $^

$(PDFS): %.pdf: %.tex Makefile
	$(LATEX) $*
	$(DVIPDF) $*

$(TARBALL): $(PDFS) $(PDFS:.pdf=.tex) $(PKGS) $(TXTS)
	$(TAR) --create --gzip --transform=$(TARDIRS) --file $@ $^

clean:
	-rm -f *.aux *.doc *.dvi *.log *.pdf *.toc

distclean: clean
	-rm -f $(TARBALL)
