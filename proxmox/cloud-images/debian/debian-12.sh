qm destroy 9012

wget -c https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2
virt-customize -a debian-12-generic-amd64.qcow2 --install qemu-guest-agent,nano
virt-sysprep -a debian-12-generic-amd64.qcow2

qm create 9012 --memory 2048 --core 2 --name debian-12 --net0 virtio,bridge=vmbr1 --ostype l26
qm importdisk 9012 debian-12-generic-amd64.qcow2 disks
sleep 5
qm set 9012 --scsihw virtio-scsi-pci --scsi0 disks:9012/vm-9012-disk-0.raw
qm set 9012 --boot c --bootdisk scsi0 

qm set 9012 --ide2 disks:cloudinit
qm set 9012 --serial0 socket --vga serial0
qm set 9012 --agent enabled=1
qm set 9012 --ipconfig0 ip=dhcp
qm set 9012 --sshkey ~/.ssh/id_rsa.pub
qm set 9012 --tags debian
qm template 9012

#rm debian-12-generic-amd64.qcow2
