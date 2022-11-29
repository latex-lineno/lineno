LATEX = latex -interaction=nonstopmode
DVIPDF = dvipdf
ZIP = zip

PDFS = fnlineno.pdf lineno.pdf lnosuppl.pdf ulineno.pdf linenoamsmathdemo.pdf
PKGS = ednmath0.sty edtable.sty fnlineno.sty lineno.sty vplref.sty
TXTS = CHANGEs.txt COPYING.txt README.txt SRCFILEs.txt

ZIPBALL = lineno.zip

.PHONY: all

all: $(ZIPBALL)

lineno.tex: lineno.sty
	sh $^

SRCFILEs.txt: $(PKGS) $(PDFS:.pdf=.tex)
	tex=`awk -f srcfiles.awk $(PKGS) $(PDFS:.pdf=.tex) | sed 's/%.*//' | tr -d '\n'`; \
	tex "$${tex}"; \
	cat $@.tmp | column -s ':' -t > $@

$(PDFS): %.pdf: %.tex Makefile
	$(LATEX) $*
	$(LATEX) $*
	$(LATEX) $*
	$(DVIPDF) $*

$(ZIPBALL): $(PDFS) $(PDFS:.pdf=.tex) $(PKGS) $(TXTS)
	rm -rf $(ZIPBALL) lineno/
	mkdir -p lineno/doc/ lineno/tex/ lineno/source/
	cp $(PDFS) $(TXTS) lineno/doc/
	cp $(PKGS) lineno/tex/
	cp $(PDFS:.pdf=.tex) lineno/source/
	mv lineno/doc/README.txt lineno/
	$(ZIP) -r $(ZIPBALL) lineno/

clean:
	-rm -rf lineno/
	-rm -f *.aux *.doc *.dvi *.log *.out *.pdf *.toc

distclean: clean
	-rm -f $(ZIPBALL)
