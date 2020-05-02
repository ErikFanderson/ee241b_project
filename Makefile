DIRS = fpga_gen_tool 

default: list 

# Export environment
export:
	conda env export --from-history | grep -v "prefix" > environment.yml

# Formats pyproject directory recursively
format:
	yapf -i -r $(DIRS)

# Runs ctags
tags:
	ctags -R .

clean:
	rm -rf build/ tags

include Makefile.toolbox

.PHONY: format clean export
