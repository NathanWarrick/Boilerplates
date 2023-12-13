qm destroy 9015

wget -c https://cloud.centos.org/centos/9-stream/x86_64/images/CentOS-Stream-GenericCloud-9-latest.x86_64.qcow2
virt-customize -a CentOS-Stream-GenericCloud-9-latest.x86_64.qcow2 --install qemu-guest-agent,nano

qm create 9015 --memory 2048 --core 2 --name centos-stream-9 --net0 virtio,bridge=vmbr1 --ostype l26
qm importdisk 9015 CentOS-Stream-GenericCloud-9-latest.x86_64.qcow2 disks
qm set 9015 --scsihw virtio-scsi-pci --scsi0 disks:9015/vm-9015-disk-0.raw

qm set 9015 --boot c --bootdisk scsi0 
qm set 9015 --ide2 disks:cloudinit
qm set 9015 --serial0 socket --vga serial0
qm set 9015 --agent enabled=1
qm set 9015 --ipconfig0 ip=dhcp
qm set 9015 --sshkey ~/.ssh/id_rsa.pub
qm set 9015 --tags centos
qm template 9015

#rm CentOS-Stream-GenericCloud-9-latest.x86_64.qcow2
