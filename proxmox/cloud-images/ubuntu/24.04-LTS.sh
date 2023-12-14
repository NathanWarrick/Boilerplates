qm destroy 9007

wget -c https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
virt-customize -a noble-server-cloudimg-amd64.img --install qemu-guest-agent,nano
sleep 2
virt-sysprep --operations machine-id -a noble-server-cloudimg-amd64.img

qm create 9007 --memory 2048 --core 2 --name ubuntu-24.04-LTS_$(date +%Y-%m-%d) --net0 virtio,bridge=vmbr1
qm importdisk 9007 noble-server-cloudimg-amd64.img disks
sleep 5
qm set 9007 --scsihw virtio-scsi-pci --scsi0 disks:9007/vm-9007-disk-0.raw
qm set 9007 --boot c --bootdisk scsi0 

qm set 9007 --ide2 disks:cloudinit
qm set 9007 --serial0 socket --vga serial0
qm set 9007 --agent enabled=1
qm set 9007 --ipconfig0 ip=dhcp
qm set 9007 --sshkey ~/.ssh/id_rsa.pub
qm set 9007 --tags ubuntu
qm template 9007

rm noble-server-cloudimg-amd64.img
