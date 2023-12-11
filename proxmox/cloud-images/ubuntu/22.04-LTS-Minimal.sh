qm destroy 9006
cp /mnt/pve/isos/template/iso/ubuntu-22.04-LTS-Minimal.img /mnt/pve/isos/template/iso/custom-ubuntu-22.04-LTS-Minimal.img
virt-customize -a /mnt/pve/isos/template/iso/custom-ubuntu-22.04-LTS-minimal.img --install qemu-guest-agent,nano
qm create 9006 --name "ubuntu-22.04-LTS-Minimal" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr1
qm importdisk 9006 /mnt/pve/isos/template/iso/custom-ubuntu-22.04-LTS-Minimal.img disks
qm set 9006 --scsihw virtio-scsi-pci --scsi0 disks:9006/vm-9006-disk-0.raw
qm set 9006 --boot c --bootdisk scsi0
qm set 9006 --ide2 disks:cloudinit
qm set 9006 --serial0 socket --vga serial0
qm set 9006 --agent enabled=1
qm set 9006 --ipconfig0 ip=dhcp
qm set 9006 --sshkey ~/.ssh/id_rsa.pub
qm template 9006
qm set 9006 --tags ubuntu
