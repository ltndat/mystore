# get su permission
sudo echo 'Start setup, follow me to ask you...'
cd ~

distro=$(awk -F = '/^ID=/ {print $2}' /etc/os-release)
UNAME=$(uname)

# if [ "$UNAME" == "Linux" ] ; then
# 	echo "Linux"
# elif [ "$UNAME" == "Darwin" ] ; then
# 	echo "Darwin"
# elif [[ "$UNAME" == CYGWIN* || "$UNAME" == MINGW* ]] ; then
# 	echo "Windows"
# fi

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

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile


if [ "$UNAME" == "Linux" ] ; then
  # enable systemctl
  if [ "$WSL_DISTRO_NAME" != "" ]; then
    cd ~
    wget https://raw.githubusercontent.com/Homebrew/homebrew-core/86a44a0a552c673a05f11018459c9f5faae3becc/Formula/python@2.rb
    brew install python@2.rb
    rm python@2.rb
  fi
  mv /usr/bin/systemctl /usr/bin/systemctl.old
  curl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl.py > /usr/bin/systemctl
  chmod +x /usr/bin/systemctl

  # install snap
  if [ "$distro" = "ubuntu" ] || [ "$distro" = "debian" ] || [ "$distro" = "kali" ]; then
    sudo apt install snapd
  elif [ "$distro" = "arch" ]; then
    git clone https://aur.archlinux.org/snapd.git
    cd snapd
    makepkg -si
    cd ..
    rm -rf snapd
  fi
  sudo systemctl enable --now snapd.socket
  sudo ln -s /var/lib/snapd/snap /snap
fi
