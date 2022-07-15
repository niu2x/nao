BUILD_DIR := build

run: header first_sector disk.img build_tools
	./tools/ddx first_sector disk.img 
	./tools/ddx -s 1048064 header disk.img 
	qemu-system-x86_64  -D log -drive file=disk.img,format=raw,media=disk,index=0 
clean:
	echo clean

disk.img:
	./tools/create_empty_disk.sh $@

first_sector: arch/x86_64/boot/first_sector.S arch/x86_64/boot/utils.h
	$(AS) -o $@.tmp -Iarch/x86_64/boot $<
	objcopy --dump-section .text=$@ $@.tmp
# 	rm $@.tmp

header: arch/x86_64/boot/header.S arch/x86_64/boot/utils.h
	$(AS) -Iarch/x86_64/boot -o $@.tmp $<
	objcopy --dump-section .text=$@ $@.tmp
# 	rm $@.tmp

build_tools: 
	make -C tools

.PHONY: clean build_tools run