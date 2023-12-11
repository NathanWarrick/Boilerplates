Install libguestfs-tools
```
apt update -y
apt install libguestfs-tools -y
```

Pull Images
```
bash -c "$(wget --header 'Authorization: token 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' https://raw.githubusercontent.com/NathanWarrick/Boilerplates/main/proxmox/cloud-images/ubuntu/update-images.sh)"
```

Update Templates
```
bash -c "$(wget --header 'Authorization: token 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' https://raw.githubusercontent.com/NathanWarrick/Boilerplates/main/proxmox/cloud-images/ubuntu/update-templates.sh)"
```

Install Docker and Portainer Agent
```
sudo bash -c "$(wget --header 'Authorization: token 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' https://raw.githubusercontent.com/NathanWarrick/Boilerplates/main/docker/docker-portainer.sh)"
```