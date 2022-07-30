LATEX = latex -interaction=nonstopmode
DVIPDF = dvipdf
ZIP = zip

PDFS = fnlineno.pdf lineno.pdf lnosuppl.pdf ulineno.pdf linenoamsmathdemo.pdf
PKGS = ednmath0.sty edtable.sty fnlineno.sty lineno.sty vplref.sty
TXTS = CHANGEs.txt COPYING.txt README.txt SRCFILEs.txt

ZIPBALL = lineno.tds.zip

.PHONY: all

all: $(ZIPBALL)

lineno.tex: lineno.sty
	sh $^

$(PDFS): %.pdf: %.tex Makefile
	$(LATEX) $*
	$(LATEX) $*
	$(LATEX) $*
	$(DVIPDF) $*

$(ZIPBALL): $(PDFS) $(PDFS:.pdf=.tex) $(PKGS) $(TXTS)
	rm -rf zipball/
	mkdir -p zipball/doc/latex/lineno/ zipball/tex/latex/lineno/ zipball/source/latex/lineno/
	cp $(PDFS) $(TXTS) zipball/doc/latex/lineno/
	cp $(PKGS) zipball/tex/latex/lineno/
	cp $(PDFS:.pdf=.tex) zipball/source/latex/lineno/
	cd zipball/ && $(ZIP) -r ../$(ZIPBALL) *

clean:
	-rm -f *.aux *.doc *.dvi *.log *.out *.pdf *.toc

distclean: clean
	-rm -f $(ZIPBALL)
