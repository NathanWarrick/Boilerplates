qm destroy 9021

wget -c https://download.fedoraproject.org/pub/fedora/linux/releases/39/Server/x86_64/images/Fedora-Server-KVM-39-1.5.x86_64.qcow2
virt-customize -a Fedora-Server-KVM-39-1.5.x86_64.qcow2 --install qemu-guest-agent,nano

qm create 9021 --memory 2048 --core 2 --name openSUSE-leap-15.5-Minimal --net0 virtio,bridge=vmbr1
qm importdisk 9021 Fedora-Server-KVM-39-1.5.x86_64.qcow2 disks
qm set 9021 --scsihw virtio-scsi-pci --scsi0 disks:9021/vm-9021-disk-0.raw
qm set 9021 --boot c --bootdisk scsi0 

qm set 9021 --ide2 disks:cloudinit
qm set 9021 --serial0 socket --vga serial0
qm set 9021 --agent enabled=1
qm set 9021 --ipconfig0 ip=dhcp
qm set 9021 --sshkey ~/.ssh/id_rsa.pub
qm set 9021 --tags fedora
qm template 9021

#rm Fedora-Server-KVM-39-1.5.x86_64.qcow2
