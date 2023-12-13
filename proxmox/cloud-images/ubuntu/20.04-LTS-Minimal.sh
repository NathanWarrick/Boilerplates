qm destroy 9004

wget -c https://cloud-images.ubuntu.com/minimal/releases/focal/release/ubuntu-20.04-minimal-cloudimg-amd64.img
virt-customize -a /ubuntu-20.04-minimal-cloudimg-amd64.img --install qemu-guest-agent,nano
sleep 2
virt-sysprep --operations machine-id -a ubuntu-20.04-minimal-cloudimg-amd64.img

qm create 9004 --memory 2048 --core 2 --name ubuntu-20.04-LTS-Minimal --net0 virtio,bridge=vmbr1
qm importdisk 9004 ubuntu-20.04-minimal-cloudimg-amd64.img disks
sleep 5
qm set 9004 --scsihw virtio-scsi-pci --scsi0 disks:9004/vm-9004-disk-0.raw
qm set 9004 --boot c --bootdisk scsi0 

qm set 9004 --ide2 disks:cloudinit
qm set 9004 --serial0 socket --vga serial0
qm set 9004 --agent enabled=1
qm set 9004 --ipconfig0 ip=dhcp
qm set 9004 --sshkey ~/.ssh/id_rsa.pub
qm set 9004 --tags ubuntu
qm template 9004

rm ubuntu-20.04-minimal-cloudimg-amd64.img
