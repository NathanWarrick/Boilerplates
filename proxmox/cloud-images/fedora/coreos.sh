qm destroy 9020

wget -c https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/39.20231119.3.0/x86_64/fedora-coreos-39.20231119.3.0-live.x86_64.iso
virt-customize -a fedora-coreos-39.20231119.3.0-live.x86_64.iso --install qemu-guest-agent,nano

qm create 9020 --memory 2048 --core 2 --name openSUSE-leap-15.5-Minimal --net0 virtio,bridge=vmbr1
qm importdisk 9020 fedora-coreos-39.20231119.3.0-live.x86_64.iso disks
qm set 9020 --scsihw virtio-scsi-pci --scsi0 disks:9020/vm-9020-disk-0.raw
qm set 9020 --boot c --bootdisk scsi0 

qm set 9020 --ide2 disks:cloudinit
qm set 9020 --serial0 socket --vga serial0
qm set 9020 --agent enabled=1
qm set 9020 --ipconfig0 ip=dhcp
qm set 9020 --sshkey ~/.ssh/id_rsa.pub
qm set 9020 --tags fedora
qm template 9020

#rm fedora-coreos-39.20231119.3.0-live.x86_64.iso
