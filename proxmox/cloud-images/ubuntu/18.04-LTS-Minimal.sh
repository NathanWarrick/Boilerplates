qm destroy 9002

wget -c https://cloud-images.ubuntu.com/minimal/releases/bionic/release/ubuntu-18.04-minimal-cloudimg-amd64.img
virt-customize -a ubuntu-18.04-minimal-cloudimg-amd64.img --install qemu-guest-agent,nano
sleep 2
virt-sysprep --operations machine-id -a ubuntu-18.04-minimal-cloudimg-amd64.img

qm create 9002 --memory 2048 --core 2 --name ubuntu-18.04-LTS-Minimal--$(date +%d-%m-%Y) --net0 virtio,bridge=vmbr1  --pool Templates
qm importdisk 9002 ubuntu-18.04-minimal-cloudimg-amd64.img disks
sleep 5
qm set 9002 --scsihw virtio-scsi-pci --scsi0 disks:9002/vm-9002-disk-0.raw
qm disk move 9002 scsi0 disks --format qcow2 --delete
qm set 9002 --boot c --bootdisk scsi0 

qm set 9002 --ide2 disks:cloudinit
qm set 9002 --serial0 socket --vga serial0
qm set 9002 --agent enabled=1
qm set 9002 --ipconfig0 ip=dhcp
qm set 9002 --sshkey ~/.ssh/id_rsa.pub
qm set 9002 --tags ubuntu
qm template 9002

rm ubuntu-18.04-minimal-cloudimg-amd64.img
