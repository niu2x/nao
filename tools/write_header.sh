#!/bin/bash
header=$1
disk=$2
objcopy --dump-section .text=${header}.code $header
objcopy --dump-section .data=${header}.data $header
./tools/ddx -s 1048064 ${header}.code $disk 
data_offset=$(readelf -S ${header}|grep ".data"|sed 's/.*BITS//g'|sed 's/  */ /g'|cut -d' ' -f 2|while read item; do echo $(( 0x${item} - 0x10000 + 1048064)); done)
./tools/ddx -s ${data_offset} ${header}.data $disk 

