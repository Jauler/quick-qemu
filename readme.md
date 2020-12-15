# QEMU Bootstrap scripts for linux VMs

Just some simple scripts to quickly create VMs.

## Usage

#### Configure
Open create.sh and configure:
* CORES_COUNT
* MEMORY_SIZE
* DISK_SIZE
* DISK_FILE
* INSTALLATION_MEDIA_URL
* INSTALLATION_MEDIA_CHECKSUM
* INSTALLATION_MEDIA_FILE

according to your needs.
The defaults are for debian buster, and should work out-of-the-box.

#### VM Installation

just run:
```sh
./create.sh
```
and follow installation procedure.

After this, you should have qcow2 disk image created with the name configured in previous step.

#### Running the VM

Once disk image is ready, just issue:
```sh
./run.sh path/to/disk/image.qcow
```

If VM is configured to use QEMU console, the output will be in terminal.
Graphical output is disabled.

#### Connect to the VM

VM should have an ssh server running.
This ssh server should be reachable on host via localhost port 2223

```sh
ssh root@localhost -p2223
```




