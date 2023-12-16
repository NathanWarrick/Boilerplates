qm destroy 9006

wget -c https://cloud-images.ubuntu.com/minimal/releases/jammy/release/ubuntu-22.04-minimal-cloudimg-amd64.img
virt-customize -a ubuntu-22.04-minimal-cloudimg-amd64.img --install qemu-guest-agent,nano
sleep 2
virt-sysprep --operations machine-id -a ubuntu-22.04-minimal-cloudimg-amd64.img

qm create 9006 --memory 2048 --core 2 --name ubuntu-22.04-LTS-Minimal--$(date +%d-%m-%Y) --net0 virtio,bridge=vmbr1
qm importdisk 9006 ubuntu-22.04-minimal-cloudimg-amd64.img disks
sleep 5
qm set 9006 --scsihw virtio-scsi-pci --scsi0 disks:9006/vm-9006-disk-0.raw
qm set 9006 --boot c --bootdisk scsi0 

qm set 9006 --ide2 disks:cloudinit
qm set 9006 --serial0 socket --vga serial0
qm set 9006 --agent enabled=1
qm set 9006 --ipconfig0 ip=dhcp
qm set 9006 --sshkey ~/.ssh/id_rsa.pub
qm set 9006 --tags ubuntu
qm template 9006

rm ubuntu-22.04-minimal-cloudimg-amd64.img
