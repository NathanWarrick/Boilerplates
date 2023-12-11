qm destroy 9001
cp /mnt/pve/isos/template/iso/ubuntu-18.04-LTS.img /mnt/pve/isos/template/iso/custom-ubuntu-18.04-LTS.img
virt-customize -a /mnt/pve/isos/template/iso/custom-ubuntu-18.04-LTS.img --install qemu-guest-agent,nano
qm create 9001 --name "ubuntu-18.04-LTS" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr1
qm importdisk 9001 /mnt/pve/isos/template/iso/custom-ubuntu-18.04-LTS.img disks
qm set 9001 --scsihw virtio-scsi-pci --scsi0 disks:9001/vm-9001-disk-0.raw
qm set 9001 --boot c --bootdisk scsi0
qm set 9001 --ide2 disks:cloudinit
qm set 9001 --serial0 socket --vga serial0
qm set 9001 --agent enabled=1
qm set 9001 --ipconfig0 ip=dhcp
qm set 9001 --sshkey ~/.ssh/id_rsa.pub
qm template 9001
qm set 9001 --tags ubuntu
