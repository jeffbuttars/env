#!/bin/bash

PKGS="apt-transport-https ca-certificates gnupg lsb-release \
	vim git i3 zsh virtualbox virtualbox-guest-utils \
	virtualbox-guest-additions-iso virtualbox-qt curl wget python3-isort \
	black flake8 python3-pynvim software-properties-common fasd \
    nmap arp-scan netcat socat kde-full yakuake xautolock prettyping \
    fzf tmux ripgrep silversearcher-ag polybar picom neovim yarn keychain google-chrome-stable \
    docker-ce docker-ce-cli containerd.io python3.9 nginx xsel jq dbeaver-ce bashtop"

sudo add-apt-repository -y ppa:kgilmer/speed-ricer
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo add-apt-repository -y ppa:serge-rider/dbeaver-ce
sudo add-apt-repository -y ppa:bashtop-monitor/bashtop

echo "Use the latgest Git"
sudo add-apt-repository -y ppa:git-core/ppa

# i3 wm repo
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2022.02.17_all.deb keyring.deb SHA256:52053550c4ecb4e97c48900c61b2df4ec50728249d054190e8a0925addb12fc6
sudo apt install ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list


# Yarn repo
curl -Ss https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# Google Repo
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo add-apt-repository -y "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main"

# Docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

sudo apt update
sudo apt upgrade
sudo apt install $PKGS

sudo systemctl enable nginx
sudo systemctl start nginx

#echo "Installing docker ...."
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
#echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# sudo apt-get update
# sudo apt-get install docker-ce docker-ce-cli containerd.io

echo "Installing docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod 755 /usr/local/bin/docker-compose

echo "Installing Poetry..."
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -

# echo "Download and install google chrome ..."
# cd /tmp
# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# sudo apt install ./google-chrome-stable_current_amd64.deb
# cd
# sudo apt install ./google-chrome-stable_current_amd64.deb

echo "Installing all nerd fonts..."

if [ -d $HOME/Downloads/nerd-fonts ]; then
	cd $HOME/Downloads/nerd-fonts
	git pull
	cd -
else
	git clone https://github.com/ryanoasis/nerd-fonts $HOME/Downloads/nerd-fonts
fi

cd $HOME/Downloads/nerd-fonts
./install.sh
cd -

echo "Install starship"
sh -c "$(curl -fsSL https://starship.rs/install.sh)"


echo "Install nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# My personal stuffs
scp -P8022 -r "jeff@newjes.us:.ssh/*" ~/.ssh/
chmod 700 $HOME/.ssh
chmod 600 $HOME/.ssh/*


cd
mkdir -p .upkg

if [ ! -d .upkg/env ]; then
    git clone git@github.com:jeffbuttars/env .upkg/env
fi

cd .upkg/env/_upkg/
./install
cd -

if [ ! -d .upkg/nvim ]; then
    git clone git@github.com:jeffbuttars/nvim .upkg/nvim
fi

cd .upkg/nvim/_upkg/
./install
cd -

mkdir -p Dev/BST
if [ ! -d Dev/BST/defenseos ]; then
    cd Dev/BST
    git clone git@github.com:jeffbuttars/defenseos.git defenseos
fi


echo "In a new terminal run:"
echo "nvm install stable"
echo "nvm alias bst=stable"
echo ""
echo "You'll need to manauly got install Zoom, Slack, Google Chrome "
