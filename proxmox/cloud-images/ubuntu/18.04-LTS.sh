qm destroy 9001
wget -c https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img
qm create 9001 --memory 2048 --core 2 --name ubuntu-18.04-LTS --net0 virtio,bridge=vmbr1
qm importdisk 9001 bionic-server-cloudimg-amd64.img disks
qm set 9001 --scsihw virtio-scsi-pci --scsi0 disks:9001/vm-9001-disk-0.raw
sleep 10 # Give the disk time to mount
virt-customize -a /mnt/pve/disks/images/9001/vm-9001-disk-0.raw --install qemu-guest-agent,nano
qm set 9001 --boot c --bootdisk scsi0 
qm set 9001 --ide2 disks:cloudinit
qm set 9001 --serial0 socket --vga serial0
qm set 9001 --agent enabled=1
qm set 9001 --ipconfig0 ip=dhcp
qm set 9001 --sshkey ~/.ssh/id_rsa.pub
qm set 9001 --tags ubuntu
qm template 9001
rm bionic-server-cloudimg-amd64.img

