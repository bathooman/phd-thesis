export TEXINPUTS := .:./stylefiles//:$(TEXINPUTS)
export BSTINPUTS := .:./stylefiles//:$(BSTINPUTS)
export SHELL := /bin/bash

MAIN = main

.PHONY: default
default: $(MAIN).pdf

.PHONY: all
all: $(MAIN).pdf

.PHONY: FORCE
%.pdf: %.tex References.bib FORCE
	latexmk $(OPT) --synctex=1 -shell-escape -pdf $*

.PHONY: continuous
continuous: default
	OPT="-pvc -halt-on-error" $(MAKE) default

.PHONY: clean
clean:
	latexmk -C
	$(RM) *.bbl *.synctex.gz comment.cut

.PHONY: distclean
distclean: clean
	$(RM) -f $(MAIN).pdf $(MAIN).dvi
