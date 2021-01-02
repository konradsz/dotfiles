#!/bin/sh

echo -n 'Enter your GIT name: '
#read git_name
git_name='Konrad Szymoniak'
echo -n 'Enter your GIT email: '
#read git_email
git_email='szymoniak.konrad@gmail.com'

sudo apt update
sudo apt upgrade -y

# Basic dependencies
sudo apt install curl g++ cmake libssl-dev pkg-config \
    libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev \
    python3 -y

# Git
sudo apt install -y git
git config --global user.name "$git_name"
git config --global user.email "$git_email"
git config --global core.editor "nvim"

# Neovim
sudo apt install neovim -y
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.config/nvim
cp ./neovim/init.vim ~/.config/nvim/
nvim +PlugInstall +qall

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Utilities and programs written in Rust
cargo install cargo-edit
cargo install alacritty
cargo install exa

# Docker
sudo apt install \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker $USER

# Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# i3
sudo apt install i3 -y
mkdir -p ~/.config/i3
cp ./i3/config ~/.config/i3/

# Polybar

# Visual Code

# fish
sudo apt-add-repository ppa:fish-shell/release-3 -y
sudo apt update
sudo apt install fish -y
mkdir -p ~/.config/fish
cp ./fish/config.fish ~/.config/fish/
#chsh -s /usr/bin/fish

# Disable lock screen and set idle delay to 30 minutes
gsettings set org.gnome.desktop.lockdown disable-lock-screen true
gsettings set org.gnome.desktop.session idle-delay $((30*60))

sudo apt autoremove
