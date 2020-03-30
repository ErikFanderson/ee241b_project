# Project: report
# Author: Erik Anderson
# Date: 10/03/2020

MAIN:=main
default:=generated/$(MAIN).pdf

# Builds twice for references and toc 
$(default): $(MAIN).tex
	pdflatex $(MAIN).tex
	bibtex $(MAIN)
	pdflatex $(MAIN).tex > /dev/null 2>&1 
	mkdir -p generated 
	mv $(MAIN).blg $(MAIN).bbl $(MAIN).log $(MAIN).aux $(MAIN).pdf $(MAIN).out generated/

# Open up the generated pdf with evince after build
.PHONY: view 
view: $(default) 
	evince generated/$(MAIN).pdf

.PHONY: clean 
clean:
	rm -rf generated/ 

