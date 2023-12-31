qm destroy 9011

wget -c https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2
virt-customize -a debian-11-generic-amd64.qcow2 --install qemu-guest-agent,nano
sleep 2
virt-sysprep --operations machine-id -a debian-11-generic-amd64.qcow2

qm create 9011 --memory 2048 --core 2 --name debian-11--$(date +%d-%m-%Y) --net0 virtio,bridge=vmbr1  --pool Templates --ostype l26
qm importdisk 9011 debian-11-generic-amd64.qcow2 disks
sleep 5
qm set 9011 --scsihw virtio-scsi-pci --scsi0 disks:9011/vm-9011-disk-0.raw
qm disk move 9011 scsi0 disks --format qcow2 --delete
qm set 9011 --boot c --bootdisk scsi0 

qm set 9011 --ide2 disks:cloudinit
qm set 9011 --serial0 socket --vga serial0
qm set 9011 --agent enabled=1
qm set 9011 --ipconfig0 ip=dhcp
qm set 9011 --sshkey ~/.ssh/id_rsa.pub
qm set 9011 --tags debian
qm template 9011

rm debian-11-generic-amd64.qcow2
