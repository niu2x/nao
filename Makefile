BUILD_DIR := build

clean:
	echo clean

build_tools: 
	make -C tools

.PHONY: clean