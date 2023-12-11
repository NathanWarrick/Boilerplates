qm destroy 9004
cp /mnt/pve/isos/template/iso/ubuntu-20.04-LTS-Minimal.img /mnt/pve/isos/template/iso/custom-ubuntu-20.04-LTS-Minimal.img
virt-customize -a /mnt/pve/isos/template/iso/custom-ubuntu-20.04-LTS-minimal.img --install qemu-guest-agent,nano
qm create 9004 --name "ubuntu-20.04-LTS-Minimal" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr1
qm importdisk 9004 /mnt/pve/isos/template/iso/custom-ubuntu-20.04-LTS-Minimal.img disks
qm set 9004 --scsihw virtio-scsi-pci --scsi0 disks:9004/vm-9004-disk-0.raw
qm set 9004 --boot c --bootdisk scsi0
qm set 9004 --ide2 disks:cloudinit
qm set 9004 --serial0 socket --vga serial0
qm set 9004 --agent enabled=1
qm set 9004 --ipconfig0 ip=dhcp
qm set 9004 --sshkey ~/.ssh/id_rsa.pub
qm template 9004
qm set 9004 --tags ubuntu
