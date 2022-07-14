BUILD_DIR := build

clean:
	echo clean

disk.img:
	./tools/create_empty_disk.sh $@

build_tools: 
	make -C tools

.PHONY: clean