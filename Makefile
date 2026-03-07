ifneq ($(V),1)
Q = @echo "Making $@";
DEVNULL = >/dev/null 2>&1
else
Q = echo; echo ">>>>> Making $@ <<<<<"; echo;
DEVNULL =
endif

LATEX = latex -interaction=nonstopmode
DVIPDF = dvipdf
ZIP = zip
ZIPINFO = zipinfo
DIFFPDF = diff-pdf --mark-differences --grayscale

PDFS = fnlineno.pdf lineno.pdf lnosuppl.pdf ulineno.pdf
PKGS = ednmath0.sty edtable.sty fnlineno.sty lineno.sty vplref.sty
TXTS = CHANGEs.txt COPYING.txt README.md SRCFILEs.txt

ZIPBALL = lineno.zip

.PHONY: all check zip

all: check zip
	$(Q)tag=`git log -1 --pretty='format:%s' | sed -n 's/^lineno version \([0-9][0-9.]*\)$$/v\1/p'` && \
	if test "X$${tag}" != X; then \
		echo ">>> Tagged version $${tag} <<<"; \
		git tag -f $${tag}; \
	fi

zip: $(ZIPBALL)

lineno.tex: lineno.sty Makefile
	$(Q)sh $^ $(DEVNULL)

SRCFILEs.txt: $(PKGS) $(PDFS:.pdf=.tex) Makefile
	$(Q)tex=`gawk -f srcfiles.awk $(PKGS) $(PDFS:.pdf=.tex) | sed 's/%.*//' | tr -d '\n'` && \
	tex -jobname=SRCFILEs "$${tex}" $(DEVNULL) && \
	cat $@.tmp | column -s ':' -t > $@

$(PDFS): %.pdf: %.tex $(PKGS) Makefile
	$(Q)$(LATEX) $* $(DEVNULL) && \
	$(LATEX) $* $(DEVNULL) && \
	$(LATEX) $* $(DEVNULL) && \
	$(DVIPDF) $* $(DEVNULL)

$(ZIPBALL): $(PDFS) $(PDFS:.pdf=.tex) $(PKGS) $(TXTS) Makefile
	$(Q)rm -rf $(ZIPBALL) lineno/ && \
	mkdir -p lineno/doc/ lineno/tex/ lineno/source/ && \
	cp $(PDFS) $(TXTS) lineno/doc/ && \
	cp $(PKGS) lineno/tex/ && \
	cp $(PDFS:.pdf=.tex) lineno/source/ && \
	mv lineno/doc/README.md lineno/ && \
	find lineno -type d | xargs chmod 0755 && \
	find lineno -type f | xargs chmod 0644 && \
	$(ZIP) -qr $(ZIPBALL) lineno/ && \
	echo && \
	echo "------------------------------- zipball --------------------------------" && \
	$(ZIPINFO) $(ZIPBALL) && \
	echo

check:
	$(Q)tests="$(sort $(patsubst %.tex,%.trs,$(wildcard test/*/test*.tex)))" && \
	rm -f $${tests} && \
	$(MAKE) --no-print-directory $${tests} && \
	echo && \
	echo "============================= test results =============================" && \
	cat test/*/test*.trs | sort && \
	echo && \
	if grep -q ': FAILED :' test/*/test*.trs; then exit 1; fi

%.trs:
	$(Q)export TEXINPUTS="$${PWD}:" && \
	cd $(dir $*) && \
	jobname="$(basename $(notdir $*))" && \
	test="\RequirePackage{etoolbox}\AfterEndPreamble{\title{$*}\date{}\maketitle}\input{$${jobname}}" && \
	$(LATEX) -jobname="$${jobname}" "$${test}" $(DEVNULL) && \
	$(LATEX) -jobname="$${jobname}" "$${test}" $(DEVNULL) && \
	$(LATEX) -jobname="$${jobname}" "$${test}" $(DEVNULL) && \
	$(DVIPDF) "$${jobname}" $(DEVNULL) && \
	if ! test -f "ref-$${jobname}.pdf"; then \
		printf "%-64s : %s\n" "$(basename $@)" "FAILED : missing $(dir $*)ref-$${jobname}.pdf" > "$${jobname}.trs"; \
	elif $(DIFFPDF) --output-diff="diff-$${jobname}.pdf" "ref-$${jobname}.pdf" "$${jobname}.pdf"; then \
		printf "%-64s : %s\n" "$(basename $@)" PASSED > "$${jobname}.trs"; \
		rm -f "$${jobname}.pdf" "diff-$${jobname}.pdf"; \
	else \
		printf "%-64s : %s\n" "$(basename $@)" "FAILED : see $(dir $*)diff-$${jobname}.pdf" > "$${jobname}.trs"; \
	fi

clean:
	-git clean -Xdf
