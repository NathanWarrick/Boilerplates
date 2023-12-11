qm destroy 9007
cp /mnt/pve/isos/template/iso/ubuntu-24.04-LTS.img /mnt/pve/isos/template/iso/custom-ubuntu-24.04-LTS.img
virt-customize -a /mnt/pve/isos/template/iso/custom-ubuntu-24.04-LTS.img --install qemu-guest-agent,nano
qm create 9007 --name "ubuntu-24.04-LTS" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr1
qm importdisk 9007 /mnt/pve/isos/template/iso/custom-ubuntu-24.04-LTS.img disks
qm set 9007 --scsihw virtio-scsi-pci --scsi0 disks:9007/vm-9007-disk-0.raw
qm set 9007 --boot c --bootdisk scsi0
qm set 9007 --ide2 disks:cloudinit
qm set 9007 --serial0 socket --vga serial0
qm set 9007 --agent enabled=1
qm set 9007 --ipconfig0 ip=dhcp
qm set 9007 --sshkey ~/.ssh/id_rsa.pub
qm template 9007
qm set 9007 --tags ubuntu
