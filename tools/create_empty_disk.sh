#!/bin/bash
img=$1

dd if=/dev/zero of=$img bs=1M count=512
fdisk $img << EOF
g
n


+128M
n



w
EOF
