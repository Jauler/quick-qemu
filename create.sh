#!/bin/bash

set -e

# General information about the virtual machine to be created
CORES_COUNT=4
MEMORY_SIZE=8G
DISK_SIZE=32G
DISK_FILE=debian.qcow
INSTALLATION_MEDIA_URL='https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.7.0-amd64-netinst.iso'
INSTALLATION_MEDIA_CHECKSUM='b317d87b0a3d5b568f48a92dcabfc4bc51fe58d9f67ca13b013f1b8329d1306d'
INSTALLATION_MEDIA_FILE='debian-10.7.0-amd64-netinst.iso'


# Create disk image
qemu-img create -f qcow2 $DISK_FILE 32G

# Download installation media
if [ ! -f $INSTALLATION_MEDIA_FILE ]; then
	curl -L $INSTALLATION_MEDIA_URL --output $INSTALLATION_MEDIA_FILE
fi
if sha256sum $INSTALLATION_MEDIA_FILE | grep $INSTALLATION_MEDIA_CHECKSUM; then
	echo "Using $INSTALLATION_MEDIA_FILE as installation media"
else
	echo "Checksum mismatch for installation media"
	exit -1;
fi;

# Start installation
qemu-system-x86_64 \
	-enable-kvm \
	-cpu host \
	-m $MEMORY_SIZE \
	-smp $CORES_COUNT \
	-drive file=$DISK_FILE,if=virtio \
	-cdrom $INSTALLATION_MEDIA_FILE \
	-display gtk \
	-netdev user,id=net0 \
	-device virtio-net,netdev=net0 \

