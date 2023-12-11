qm destroy 9002
cp /mnt/pve/isos/template/iso/ubuntu-18.04-LTS-Minimal.img /mnt/pve/isos/template/iso/custom-ubuntu-18.04-LTS-Minimal.img
virt-customize -a /mnt/pve/isos/template/iso/custom-ubuntu-18.04-LTS-minimal.img --install qemu-guest-agent,nano
qm create 9002 --name "ubuntu-18.04-LTS-Minimal" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr1
qm importdisk 9002 /mnt/pve/isos/template/iso/custom-ubuntu-18.04-LTS-Minimal.img disks
qm set 9002 --scsihw virtio-scsi-pci --scsi0 disks:9002/vm-9002-disk-0.raw
qm set 9002 --boot c --bootdisk scsi0
qm set 9002 --ide2 disks:cloudinit
qm set 9002 --serial0 socket --vga serial0
qm set 9002 --agent enabled=1
qm set 9002 --ipconfig0 ip=dhcp
qm set 9002 --sshkey ~/.ssh/id_rsa.pub
qm template 9002
qm set 9002 --tags ubuntu
