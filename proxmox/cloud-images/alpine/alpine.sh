qm destroy 9030

wget -c https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/x86_64/alpine-virt-3.19.0-x86_64.iso
virt-customize -a alpine-virt-3.19.0-x86_64.iso --install qemu-guest-agent,nano #TODO Virt-Customise isn't working

qm create 9030 --memory 2048 --core 2 --name alpine --net0 virtio,bridge=vmbr1
qm importdisk 9030 alpine-virt-3.19.0-x86_64.iso disks
qm set 9030 --scsihw virtio-scsi-pci --scsi0 disks:9030/vm-9030-disk-0.raw
qm set 9030 --boot c --bootdisk scsi0 

qm set 9030 --ide2 disks:cloudinit
qm set 9030 --serial0 socket --vga serial0
qm set 9030 --agent enabled=1
qm set 9030 --ipconfig0 ip=dhcp
qm set 9030 --sshkey ~/.ssh/id_rsa.pub
qm set 9030 --tags alpine
qm template 9030

#rm alpine-virt-3.19.0-x86_64.iso
