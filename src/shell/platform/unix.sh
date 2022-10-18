# get su permission
sudo echo 'Start setup, follow me to ask you...'
distro=$(awk -F = '/^ID=/ {print $2}' /etc/os-release)
UNAME=$(uname)

cd ~

if [ "$distro" = "ubuntu" ] || [ "$distro" = "debian" ] || [ "$distro" = "kali" ]; then
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get install git wget build-essential -y
  sudo apt-get upgrade -y
  sudo apt-get update -y
elif [ "$distro" = "arch" ]; then
  sudo pacman -S base-devel
  sudo pacman -Su git wget
else
  echo "Unknown linux distro"
fi

# Snap
if [ "$UNAME" == "Linux" ] ; then
  if [ "$distro" = "ubuntu" ] || [ "$distro" = "debian" ] || [ "$distro" = "kali" ]; then
    sudo apt install snapd
  elif [ "$distro" = "arch" ]; then
    git clone https://aur.archlinux.org/snapd.git
    cd snapd
    makepkg -si
    cd ..
    rm -rf snapd
    sudo ln -s /var/lib/snapd/snap /snap
  fi
fi

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile

# Enable Systemctl on wsl
if [ "$WSL_DISTRO_NAME" != "" ]; then
  brew install python
  sudo ln -sf $(which python3) /usr/bin/python2
  sudo mv /usr/bin/systemctl /usr/bin/systemctl.old
  sudo curl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl.py > /usr/bin/systemctl
  sudo chmod +x /usr/bin/systemctl
fi
sudo systemctl enable --now snapd.socket

# if [ "$UNAME" == "Linux" ] ; then
# 	echo "Linux"
# elif [ "$UNAME" == "Darwin" ] ; then
# 	echo "Darwin"
# elif [[ "$UNAME" == CYGWIN* || "$UNAME" == MINGW* ]] ; then
# 	echo "Windows"
# fi