# Makefile for the lineno.sty website update
# $Id: Makefile,v 3.0 1999/06/11 22:40:46 stephan Exp $

DVIPS = dvips $(DVIPSFLAGS)
TEX   = latex

TARGET=lineno
MANUAL=ulineno
EXTENSIONS = bframe ilineno mlineno numquote rlineno 
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

../lineno.tar.gz: $(READMES) $(TARGET).sty $(TARGET).tex $(MANUAL).tex \
                  $(addsuffix .sty,$(EXTENSIONS))
	tar -C .. -czf $@ $(addprefix lineno/,$^)

clean:
	rm -f *.aux *.dvi *.log *.ps *.toc *.snc *~

veryclean: clean
	rm -f ../lineno.tar.gz $(TARGET).tex $(TARGET).ps.gz $(MANUAL).ps.gz
