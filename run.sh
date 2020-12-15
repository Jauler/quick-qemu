#!/bin/bash

if [ -z $1 ]; then
	echo "Usage: $0 <disk image file>"
	exit -1
fi

CORES_COUNT=4
MEMORY_SIZE=8G
DISK_SIZE=32G
DISK_FILE=$1

# Start installation
qemu-system-x86_64 \
	-enable-kvm \
	-cpu host \
	-m $MEMORY_SIZE \
	-smp $CORES_COUNT \
	-drive file=$DISK_FILE,if=virtio \
	-netdev user,id=net0,hostfwd=tcp:127.0.0.1:2223-:22 \
	-device virtio-net,netdev=net0 \
	-nographic \



