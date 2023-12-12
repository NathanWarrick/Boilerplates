#sudo bash -c "$(wget -qLO - https://raw.githubusercontent.com/NathanWarrick/Boilerplates/main/docker/docker-portainer.sh)"

apt-get update -y && sudo apt-get upgrade -y
apt-get install docker.io
systemctl start docker
systemctl enable docker
docker run -d \
  -p 9001:9001 \
  --name portainer_agent \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker/volumes:/var/lib/docker/volumes \
  portainer/agent:2.19.4
