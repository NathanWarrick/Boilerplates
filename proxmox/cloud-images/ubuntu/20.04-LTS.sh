qm destroy 9003
cp /mnt/pve/isos/template/iso/ubuntu-20.04-LTS.img /mnt/pve/isos/template/iso/custom-ubuntu-20.04-LTS.img
virt-customize -a /mnt/pve/isos/template/iso/custom-ubuntu-20.04-LTS.img --install qemu-guest-agent,nano
qm create 9003 --name "ubuntu-20.04-LTS" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr1
qm importdisk 9003 /mnt/pve/isos/template/iso/custom-ubuntu-20.04-LTS.img disks
qm set 9003 --scsihw virtio-scsi-pci --scsi0 disks:9003/vm-9003-disk-0.raw
qm set 9003 --boot c --bootdisk scsi0
qm set 9003 --ide2 disks:cloudinit
qm set 9003 --serial0 socket --vga serial0
qm set 9003 --agent enabled=1
qm set 9003 --ipconfig0 ip=dhcp
qm set 9003 --sshkey ~/.ssh/id_rsa.pub
qm template 9003
qm set 9003 --tags ubuntu
