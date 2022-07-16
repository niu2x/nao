BUILD_DIR := build

run: header first_sector disk.img build_tools
	./tools/ddx first_sector disk.img 
	./tools/write_header.sh header disk.img
	qemu-system-x86_64  -D log -drive file=disk.img,format=raw,media=disk,index=0 
clean:
	echo clean

disk.img:
	./tools/create_empty_disk.sh $@

first_sector: arch/x86_64/boot/first_sector.S arch/x86_64/boot/utils.h
	$(AS) --m32 -o $@.tmp -Iarch/x86_64/boot $<
	objcopy --dump-section .text=$@ $@.tmp
# 	rm $@.tmp

header: arch/x86_64/boot/header.S \
		arch/x86_64/boot/main32.c \
		arch/x86_64/boot/utils.h \
		arch/x86_64/boot/boot.ld
	$(AS) --32 -c -Iarch/x86_64/boot -o header.o arch/x86_64/boot/header.S
	$(CC) -fcf-protection=none -m32 -fno-pic -c -Iarch/x86_64/boot -o main32.o arch/x86_64/boot/main32.c
	$(LD) -T arch/x86_64/boot/boot.ld header.o main32.o -o header
# 	rm $@.tmp

build_tools: 
	make -C tools

.PHONY: clean build_tools run