# Makefile for the lineno.sty website update
# $Id: Makefile,v 1.1 1998/03/10 09:44:08 stephan Exp $

DVIPS = dvips $(DVIPSFLAGS)

TARGET=lineno

all: $(TARGET).ps.gz ../lineno.tar.gz

$(TARGET).tex $(TARGET).dvi: $(TARGET).sty
	. $<

$(TARGET).ps: $(TARGET).dvi
	$(DVIPS) $< -o $@

%.gz: %
	gzip -9cf <$< >$@

../lineno.tar.gz: README $(TARGET).sty $(TARGET).tex ilineno.sty numquote.sty
	tar -C .. -czf lineno.tar.gz $(addprefix lineno/,$^)

