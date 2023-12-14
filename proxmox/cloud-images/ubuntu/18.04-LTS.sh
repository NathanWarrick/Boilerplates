qm destroy 9001

wget -c https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img
virt-customize -a bionic-server-cloudimg-amd64.img --install qemu-guest-agent,nano
sleep 2
virt-sysprep --operations machine-id -a bionic-server-cloudimg-amd64.img

qm create 9001 --memory 2048 --core 2 --name ubuntu-18.04-LTS_$(date +%Y-%m-%d) --net0 virtio,bridge=vmbr1
qm importdisk 9001 bionic-server-cloudimg-amd64.img disks
sleep 5
qm set 9001 --scsihw virtio-scsi-pci --scsi0 disks:9001/vm-9001-disk-0.raw
qm set 9001 --boot c --bootdisk scsi0 

qm set 9001 --ide2 disks:cloudinit
qm set 9001 --serial0 socket --vga serial0
qm set 9001 --agent enabled=1
qm set 9001 --ipconfig0 ip=dhcp
qm set 9001 --sshkey ~/.ssh/id_rsa.pub
qm set 9001 --tags ubuntu
qm template 9001

rm bionic-server-cloudimg-amd64.img

