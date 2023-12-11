Install libguestfs-tools
```
apt update -y
apt install libguestfs-tools -y
```

Pull Images
```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/NathanWarrick/Proxmox/main/cloud-images/ubuntu/update-images.sh)"
```

Update Templates
```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/NathanWarrick/Proxmox/main/cloud-images/ubuntu/update-templates.sh)"
```