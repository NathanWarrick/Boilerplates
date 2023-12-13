qm destroy 9005
wget -c https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-disk-kvm.img
qm create 9005 --memory 2048 --core 2 --name ubuntu-22.04-LTS --net0 virtio,bridge=vmbr1
qm importdisk 9005 jammy-server-cloudimg-amd64-disk-kvm.img disks
qm set 9005 --scsihw virtio-scsi-pci --scsi0 disks:9005/vm-9005-disk-0.raw
sleep 10 # Give the disk time to mount
virt-customize -a /mnt/pve/disks/images/9005/vm-9005-disk-0.raw --install qemu-guest-agent,nano
qm set 9005 --boot c --bootdisk scsi0 
qm set 9005 --ide2 disks:cloudinit
qm set 9005 --serial0 socket --vga serial0
qm set 9005 --agent enabled=1
qm set 9005 --ipconfig0 ip=dhcp
qm set 9005 --sshkey ~/.ssh/id_rsa.pub
qm set 9005 --tags ubuntu
qm template 9005
rm jammy-server-cloudimg-amd64-disk-kvm.img
