TESTS=tests
SRC=toolbox
DIRS = $(SRC) $(TESTS)

default: list 

# Export environment
export: environment.yml
environment.yml:
	conda env export --from-history | grep -v "prefix" > environment.yml

# Formats pyproject directory recursively
format:
	yapf -i -r $(DIRS)

# Runs ctags
tags:
	ctags -R .

clean:
	rm -rf build/ tags

.PHONY: format clean export

include Makefile.toolbox
