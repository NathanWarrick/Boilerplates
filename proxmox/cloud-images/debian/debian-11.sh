qm destroy 9011

wget -c https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2
virt-customize --install qemu-guest-agent -a debian-11-generic-amd64.qcow2,nano

qm create 9011 --memory 2048 --core 2 --name debian-11 --net0 virtio,bridge=vmbr1 --ostype l26
qm importdisk 9011 debian-11-generic-amd64.qcow2 disks
qm set 9011 --scsihw virtio-scsi-pci --scsi0 disks:9011/vm-9011-disk-0.raw
qm set 9011 --boot c --bootdisk scsi0 

qm set 9011 --ide2 disks:cloudinit
qm set 9011 --serial0 socket --vga serial0
qm set 9011 --agent enabled=1
qm set 9011 --ipconfig0 ip=dhcp
qm set 9011 --sshkey ~/.ssh/id_rsa.pub
qm set 9011 --tags debian
qm template 9011

rm debian-11-generic-amd64.qcow2
