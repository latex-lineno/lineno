LATEX = latex -interaction=nonstopmode
DVIPDF = dvipdf
ZIP = zip
ZIPINFO = zipinfo

PDFS = fnlineno.pdf lineno.pdf lnosuppl.pdf ulineno.pdf linenoamsmathdemo.pdf
PKGS = ednmath0.sty edtable.sty fnlineno.sty lineno.sty vplref.sty
TXTS = CHANGEs.txt COPYING.txt README.md SRCFILEs.txt

ZIPBALL = lineno.zip

.PHONY: all

all: $(ZIPBALL)
	tag=`git log -1 --pretty='format:%s' | sed -n 's/^lineno version \([0-9][0-9.]*\)$$/v\1/p'`; \
	if test "X$$tag" != X; then git tag -f $$tag; fi

lineno.tex: lineno.sty Makefile
	sh $^

SRCFILEs.txt: $(PKGS) $(PDFS:.pdf=.tex) Makefile
	tex=`gawk -f srcfiles.awk $(PKGS) $(PDFS:.pdf=.tex) | sed 's/%.*//' | tr -d '\n'`; \
	tex "$${tex}"; \
	cat $@.tmp | column -s ':' -t > $@

$(PDFS): %.pdf: %.tex $(PKGS) Makefile
	$(LATEX) $*
	$(LATEX) $*
	$(LATEX) $*
	$(DVIPDF) $*

$(ZIPBALL): $(PDFS) $(PDFS:.pdf=.tex) $(PKGS) $(TXTS) Makefile
	rm -rf $(ZIPBALL) lineno/
	mkdir -p lineno/doc/ lineno/tex/ lineno/source/
	cp $(PDFS) $(TXTS) lineno/doc/
	cp $(PKGS) lineno/tex/
	cp $(PDFS:.pdf=.tex) lineno/source/
	mv lineno/doc/README.md lineno/
	chmod -R u=rwX,g=r,o=r lineno/
	$(ZIP) -qr $(ZIPBALL) lineno/
	$(ZIPINFO) $(ZIPBALL)

clean:
	-rm -rf lineno/
	-rm -f *.aux *.doc *.dvi *.log *.out *.pdf *.toc *.tmp

distclean: clean
	-rm -f lineno.tex SRCFILEs.txt $(PDFS) $(ZIPBALL)
