#!/bin/sh

echo -n 'Enter your GIT name: '
read git_name
echo -n 'Enter your GIT email: '
read git_email

sudo apt update
sudo apt upgrade -y

# Basic dependencies
sudo apt install curl g++ cmake libssl-dev pkg-config \
    libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev \
    python3 default-jre net-tools htop -y

# fzf
sudo apt install fzf -y

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
~/.cargo/bin/cargo install cargo-edit
~/.cargo/bin/cargo install alacritty
~/.cargo/bin/cargo install exa
~/.cargo/bin/cargo install ripgrep

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

# Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# i3
sudo apt install i3 -y
mkdir -p ~/.config/i3
cp ./i3/config ~/.config/i3/

# Polybar
sudo apt install build-essential cmake-data python3-sphinx \
    libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev \
    libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev \
    libxcb-ewmh-dev libxcb-icccm4-dev libjsoncpp-dev -y
sudo apt install fonts-noto-core -y
git clone --recursive https://github.com/polybar/polybar polybar-repo
cd polybar-repo
mkdir -p build && cd build
cmake ..
make -j$(nproc)
sudo make install
cd ../..
rm -rf polybar-repo
mkdir -p ~/.config/polybar
cp ./polybar/launch.sh ~/.config/polybar
cp ./polybar/config ~/.config/polybar

# Visual Studio Code
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt install code
code --install-extension matklad.rust-analyzer
code --install-extension vadimcn.vscode-lldb
code --install-extension serayuzgur.crates
code --install-extension bungcip.better-toml
code --install-extension equinusocio.vsc-material-theme
code --install-extension pkief.material-icon-theme
code --install-extension tamasfe.even-better-toml
code --install-extension shd101wyy.markdown-preview-enhanced 
code --install-extension redhat.vscode-yaml
code --install-extension vscodevim.vim
code --install-extension 2gua.rainbow-brackets
mkdir -p ~/.config/Code/User
cp ./vscode/settings.json ~/.config/Code/User/

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

sudo apt autoremove -y
