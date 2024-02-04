qm destroy 9030

wget -c https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/cloud/nocloud_alpine-3.19.0-x86_64-bios-cloudinit-r0.qcow2
virt-customize -a nocloud_alpine-3.19.0-x86_64-bios-cloudinit-r0.qcow2 --install qemu-guest-agent,nano #TODO Virt-Customise isn't working
sleep 2
virt-sysprep --operations machine-id -a nocloud_alpine-3.19.0-x86_64-bios-cloudinit-r0.qcow2

qm create 9030 --memory 2048 --core 2 --name alpine--$(date +%d-%m-%Y) --net0 virtio,bridge=vmbr1  --pool Templates
qm importdisk 9030 nocloud_alpine-3.19.0-x86_64-bios-cloudinit-r0.qcow2 disks
sleep 5
qm set 9030 --scsihw virtio-scsi-pci --scsi0 disks:9030/vm-9030-disk-0.raw
qm disk move 9030 scsi0 disks --format qcow2 --delete
qm set 9030 --boot c --bootdisk scsi0 

qm set 9030 --ide2 disks:cloudinit
qm set 9030 --serial0 socket --vga serial0
qm set 9030 --agent enabled=1
qm set 9030 --ipconfig0 ip=dhcp
qm set 9030 --sshkey ~/.ssh/id_rsa.pub
qm set 9030 --tags alpine
qm template 9030

rm nocloud_alpine-3.19.0-x86_64-bios-cloudinit-r0.qcow2
