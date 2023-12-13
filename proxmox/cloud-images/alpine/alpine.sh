qm destroy 9020
wget -c https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/x86_64/alpine-virt-3.19.0-x86_64.iso
qm create 9020 --memory 2048 --core 2 --name alpine --net0 virtio,bridge=vmbr1
qm importdisk 9020 alpine-virt-3.19.0-x86_64.iso disks
qm set 9020 --scsihw virtio-scsi-pci --scsi0 disks:9020/vm-9020-disk-0.raw
sleep 10 # Give the disk time to mount
virt-customize -a /mnt/pve/disks/images/9020/vm-9020-disk-0.raw --install qemu-guest-agent
qm set 9020 --boot c --bootdisk scsi0 
qm set 9020 --ide2 disks:cloudinit
qm set 9020 --serial0 socket --vga serial0
qm set 9020 --agent enabled=1
qm set 9020 --ipconfig0 ip=dhcp
qm set 9020 --sshkey ~/.ssh/id_rsa.pub
qm set 9020 --tags alpine
qm template 9020
rm alpine-virt-3.19.0-x86_64.iso
