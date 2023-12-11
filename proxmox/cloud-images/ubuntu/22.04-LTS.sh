qm destroy 9005
cp /mnt/pve/isos/template/iso/ubuntu-22.04-LTS.img /mnt/pve/isos/template/iso/custom-ubuntu-22.04-LTS.img
virt-customize -a /mnt/pve/isos/template/iso/custom-ubuntu-22.04-LTS.img --install qemu-guest-agent,nano
qm create 9005 --name "ubuntu-22.04-LTS" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr1
qm importdisk 9005 /mnt/pve/isos/template/iso/custom-ubuntu-22.04-LTS.img disks
qm set 9005 --scsihw virtio-scsi-pci --scsi0 disks:9005/vm-9005-disk-0.raw
qm set 9005 --boot c --bootdisk scsi0
qm set 9005 --ide2 disks:cloudinit
qm set 9005 --serial0 socket --vga serial0
qm set 9005 --agent enabled=1
qm set 9005 --ipconfig0 ip=dhcp
qm set 9005 --sshkey ~/.ssh/id_rsa.pub
qm template 9005
qm set 9005 --tags ubuntu
