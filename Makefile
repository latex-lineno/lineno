# Makefile for the lineno.sty website update
# $Id: Makefile,v 1.4 1999/03/02 14:32:43 stephan Exp $

DVIPS = dvips $(DVIPSFLAGS)
TEX   = latex

TARGET=lineno
MANUAL=ulineno
EXTENSIONS = ilineno mlineno numquote itemrule bframe
READMES= README COPYING

all: $(TARGET).ps.gz $(MANUAL).ps.gz ../lineno.tar.gz

$(TARGET).tex $(TARGET).dvi: $(TARGET).sty
	. $<

$(MANUAL).dvi: $(MANUAL).tex $(TARGET).sty $(addsuffix .sty,$(EXTENSIONS))
	latex $<
	latex $<

%.ps: %.dvi
	$(DVIPS) $< -o $@

%.gz: %
	gzip -9cf <$< >$@

../lineno.tar.gz: README $(TARGET).sty $(TARGET).tex $(MANUAL).tex \
                  $(addsuffix .sty,$(EXTENSIONS))
	tar -C .. -czf $@ $(addprefix lineno/,$^)

clean:
	rm -f *.aux *.dvi *.log *.ps *.toc *.snc *~

veryclean: clean
	rm -f ../lineno.tar.gz $(TARGET).tex $(TARGET).ps.gz
