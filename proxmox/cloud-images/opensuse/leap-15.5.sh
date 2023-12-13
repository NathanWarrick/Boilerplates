qm destroy 9015
wget -c https://download.opensuse.org/distribution/leap/15.5/appliances/openSUSE-Leap-15.5-Minimal-VM.x86_64-Cloud.qcow2
qm create 9015 --memory 2048 --core 2 --name openSUSE-leap-15.5-Minimal --net0 virtio,bridge=vmbr1
qm importdisk 9015 openSUSE-Leap-15.5-Minimal-VM.x86_64-Cloud.qcow2 disks
qm set 9015 --scsihw virtio-scsi-pci --scsi0 disks:9015/vm-9015-disk-0.raw
sleep 10 # Give the disk time to mount
virt-customize -a /mnt/pve/disks/images/9015/vm-9015-disk-0.raw --install qemu-guest-agent
qm set 9015 --boot c --bootdisk scsi0 
qm set 9015 --ide2 disks:cloudinit
qm set 9015 --serial0 socket --vga serial0
qm set 9015 --agent enabled=1
qm set 9015 --ipconfig0 ip=dhcp
qm set 9015 --sshkey ~/.ssh/id_rsa.pub
qm set 9015 --tags openSUSE
qm template 9015
rm openSUSE-Leap-15.5-Minimal-VM.x86_64-Cloud.qcow2
