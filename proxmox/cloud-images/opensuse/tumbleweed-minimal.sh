qm destroy 9016
wget -c https://download.opensuse.org/tumbleweed/appliances/openSUSE-Tumbleweed-Minimal-VM.x86_64-Cloud.qcow2
qm create 9016 --memory 2048 --core 2 --name openSUSE-tumbleweed-minimal --net0 virtio,bridge=vmbr1
qm importdisk 9016 openSUSE-Tumbleweed-Minimal-VM.x86_64-Cloud.qcow2 disks
qm set 9016 --scsihw virtio-scsi-pci --scsi0 disks:9016/vm-9016-disk-0.raw
sleep 10 # Give the disk time to mount
virt-customize -a /mnt/pve/disks/images/9016/vm-9016-disk-0.raw --install qemu-guest-agent
qm set 9016 --boot c --bootdisk scsi0 
qm set 9016 --ide2 disks:cloudinit
qm set 9016 --serial0 socket --vga serial0
qm set 9016 --agent enabled=1
qm set 9016 --ipconfig0 ip=dhcp
qm set 9016 --sshkey ~/.ssh/id_rsa.pub
qm set 9016 --tags openSUSE
qm template 9016
rm openSUSE-Tumbleweed-Minimal-VM.x86_64-Cloud.qcow2
