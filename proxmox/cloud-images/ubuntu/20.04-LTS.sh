qm destroy 9003

wget -c https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-disk-kvm.img
virt-customize -a focal-server-cloudimg-amd64-disk-kvm.img --install qemu-guest-agent,nano
sleep 2
virt-sysprep --operations machine-id -a focal-server-cloudimg-amd64-disk-kvm.img

qm create 9003 --memory 2048 --core 2 --name ubuntu-20.04-LTS--$(date +%d-%m-%Y) --net0 virtio,bridge=vmbr1
qm importdisk 9003 focal-server-cloudimg-amd64-disk-kvm.img disks
sleep 5
qm set 9003 --scsihw virtio-scsi-pci --scsi0 disks:9003/vm-9003-disk-0.raw
qm disk move 9003 scsi0 disks --format qcow2 --delete
qm set 9003 --boot c --bootdisk scsi0 

qm set 9003 --ide2 disks:cloudinit
qm set 9003 --serial0 socket --vga serial0
qm set 9003 --agent enabled=1
qm set 9003 --ipconfig0 ip=dhcp
qm set 9003 --sshkey ~/.ssh/id_rsa.pub
qm set 9003 --tags ubuntu
qm template 9003

rm focal-server-cloudimg-amd64-disk-kvm.img
