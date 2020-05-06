# Project: report
# Author: Erik Anderson
# Date: 10/03/2020

MAIN = main
default = generated/$(MAIN).pdf
tmp = tmp.$(MAIN)

# Builds multiple times for toc, bib, etc...
$(default): $(MAIN).tex
	cp $(MAIN).tex $(tmp).tex
	pdflatex $(tmp).tex
	biber $(tmp)
	pdflatex $(tmp).tex > /dev/null 2>&1
	pdflatex $(tmp).tex > /dev/null 2>&1
	pdflatex $(tmp).tex
	mkdir -p generated
	mv $(tmp).pdf generated/$(MAIN).pdf
	mv $(tmp).* generated

# Open up the generated pdf with evince after build
.PHONY: view
view: $(default) 
	evince generated/$(MAIN).pdf

.PHONY: clean 
clean:
	rm -rf generated/
