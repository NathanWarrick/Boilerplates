qm destroy 9100
cp /mnt/pve/isos/template/iso/ubuntu-18.04-LTS-Minimal.img /mnt/pve/isos/template/iso/custom-ubuntu-18.04-LTS-Minimal.img
virt-customize -a /mnt/pve/isos/template/iso/custom-ubuntu-18.04-LTS-minimal.img --install qemu-guest-agent,vim
qm create 9100 --name "ubuntu-18.04-LTS-Minimal" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr1
qm importdisk 9100 /mnt/pve/isos/template/iso/custom-ubuntu-18.04-LTS-Minimal.img disks
qm set 9100 --scsihw virtio-scsi-pci --scsi0 disks:9100/vm-9100-disk-0.raw
qm set 9100 --boot c --bootdisk scsi0
qm set 9100 --ide2 disks:cloudinit
qm set 9100 --serial0 socket --vga serial0
qm set 9100 --agent enabled=1
qm set 9100 --ipconfig0 ip=dhcp
qm set 123 --sshkey ~/.ssh/id_rsa.pub
qm template 9100
qm set 9100 --tags ubuntu