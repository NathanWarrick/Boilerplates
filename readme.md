Install libguestfs-tools on Proxmox
```
apt update -y
apt install libguestfs-tools -y
```

Update Proxmox Templates
```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/NathanWarrick/Boilerplates/main/proxmox/cloud-images/update-all.sh)"
```

Install Docker and Portainer Agent on host (Ubuntu)
```
sudo bash -c "$(wget -qLO - https://raw.githubusercontent.com/NathanWarrick/Boilerplates/main/docker/docker-portainer.sh)"
```

test