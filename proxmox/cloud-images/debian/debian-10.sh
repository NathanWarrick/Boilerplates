qm destroy 9010

wget -c https://cloud.debian.org/images/cloud/buster/latest/debian-10-generic-amd64.qcow2
virt-customize --install qemu-guest-agent -a debian-10-generic-amd64.qcow2,nano

qm create 9010 --memory 2048 --core 2 --name debian-10 --net0 virtio,bridge=vmbr1 --ostype l26
qm importdisk 9010 debian-10-generic-amd64.qcow2 disks
qm set 9010 --scsihw virtio-scsi-pci --scsi0 disks:9010/vm-9010-disk-0.raw
qm set 9010 --boot c --bootdisk scsi0 

qm set 9010 --ide2 disks:cloudinit
qm set 9010 --serial0 socket --vga serial0
qm set 9010 --agent enabled=1
qm set 9010 --ipconfig0 ip=dhcp
qm set 9010 --sshkey ~/.ssh/id_rsa.pub
qm set 9010 --tags debian
qm template 9010

rm debian-10-generic-amd64.qcow2
