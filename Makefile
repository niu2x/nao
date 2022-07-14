BUILD_DIR := build

run: first_sector disk.img build_tools
	./tools/ddx first_sector disk.img 
	qemu-system-x86_64  -drive file=disk.img,format=raw,media=disk

clean:
	echo clean

disk.img:
	./tools/create_empty_disk.sh $@

first_sector: arch/x86_64/boot/first_sector.S
	$(AS) -o $@.tmp $<
	objcopy --dump-section .text=$@ $@.tmp
# 	rm $@.tmp

build_tools: 
	make -C tools

.PHONY: clean build_tools run