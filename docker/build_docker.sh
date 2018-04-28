curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update

apt-cache policy docker-ce

# 
echo "you can start install docker"

sudo apt-get install -y docker-ce

# 
echo "check docker status"
sudo systemctl status docker

# 

echo "add ${USER} to docker group"

sudo usermod -aG docker ${USER}

echo "now you need to restart current session, then you can use docker rather than sudo docker"

echo "start install docker-compose"

sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version
