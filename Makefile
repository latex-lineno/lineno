# Makefile for the lineno.sty website update
# $Id: Makefile,v 3.1 2001/07/31 02:57:33 stephan Exp $

DVIPS = dvips $(DVIPSFLAGS)
TEX   = latex

TARGET=lineno
MANUAL=ulineno
READMES= README COPYING

all: $(TARGET).ps.gz $(MANUAL).ps.gz ../lineno.tar.gz

$(TARGET).tex $(TARGET).dvi: $(TARGET).sty
	. $<

$(MANUAL).dvi: $(MANUAL).tex $(TARGET).sty
	latex $<
	latex $<

%.ps: %.dvi
	$(DVIPS) $< -o $@

%.gz: %
	gzip -9cf <$< >$@

../lineno.tar.gz: $(READMES) $(TARGET).sty $(TARGET).tex $(MANUAL).tex 
	tar -C .. -czf $@ $(addprefix lineno/,$^)

clean:
	rm -f *.aux *.dvi *.log *.ps *.toc *.snc *~

veryclean: clean
	rm -f ../lineno.tar.gz $(TARGET).tex $(TARGET).ps.gz $(MANUAL).ps.gz
