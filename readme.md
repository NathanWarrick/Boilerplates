Install libguestfs-tools
```
apt update -y
apt install libguestfs-tools -y
```

Pull Images
```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/NathanWarrick/Boilerplates/main/proxmox/cloud-images/ubuntu/update-images.sh)"
```

Update Templates
```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/NathanWarrick/Boilerplates/main/proxmox/cloud-images/ubuntu/update-templates.sh)"
```

Install Docker and Portainer Agent
```
sudo bash -c "$(wget -qLO - https://raw.githubusercontent.com/NathanWarrick/Boilerplates/main/docker/docker-portainer.sh)"
```

Test
```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/NathanWarrick/Proxmox/main/test.sh)"
```