#!/bin/sh

username="${1:?'A username is required'}"
alpine_version="${2:-'edge'}"

cat > /etc/apk/repositories <<- EOM
http://dl-cdn.alpinelinux.org/alpine/${alpine_version}/main
http://dl-cdn.alpinelinux.org/alpine/${alpine_version}/community

https://ftp.halifax.rwth-aachen.de/alpine/${alpine_version}/main
https://ftp.halifax.rwth-aachen.de/alpine/${alpine_version}/community
EOM

cat >> /etc/ssh/sshd_config <<- EOM
DenyGroups root sudo
DenyUsers root
EOM

if [ -x "$(command -v apk)" ]; then
	apk update
	apk add sudo git musl-dev gcc vim vim-doc ranger nodejs shellcheck zsh zsh-doc curl curl-doc openssh openssh-doc ufw ufw-doc ufw-openrc openssl openssl-dev
elif [ -x "$(command -v apt)" ]; then
	apt update
	apt install sudo ufw git build-essentials ranger vim zsh curl openssh
fi

ufw allow proto tcp from any to any port 80,443
ufw allow proto tcp from 10.100.102.0/24 to any port 22
ufw enable

useradd -m -U -s /bin/zsh -h "/home/${username}" "${username}"
addgroup sudo
adduser "${username}" sudo
echo '%sudo ALL=(ALL) ALL' > /etc/sudoers.d/sudo
sudo -l "${username}"

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp ./assets/.vimrc ~/.vimrc
vim +PlugInstall +qall

cp ./assets/rc.conf ~/.config/ranger/rc.conf

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sudo sh

cd /tmp || exit 1
git clone https://github.com/rust-analyzer/rust-analyzer.git
cd rust-analyzer || exit 1
cargo xtask install --server
cd - || exit 1

sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
cp ./assets/.zshrc ~/.zshrc
cp ./assets/.zprofile ~/.zprofile
