# get su permission
sudo echo 'Begin'

distro=$(awk -F = '/^ID=/ {print $2}' /etc/os-release)
UNAME=$(uname)

# if [ "$UNAME" == "Linux" ] ; then
# 	echo "Linux"
# elif [ "$UNAME" == "Darwin" ] ; then
# 	echo "Darwin"
# elif [[ "$UNAME" == CYGWIN* || "$UNAME" == MINGW* ]] ; then
# 	echo "Windows"
# fi

# wsl setup
if [ "$WSL_DISTRO_NAME" != "" ]; then
  # Arch linux
  if [ "$distro" = "$arch" ]; then
    sudo echo '' >> /etc/wsl.conf
    sudo echo '[user]' >> /etc/wsl.conf
    sudo echo 'default=user' >> /etc/wsl.conf
    sudo echo 'user ALL=(ALL) ALL' >> /etc/sudoers
    sudo useradd -m user
    sudo passwd user
  fi
fi

if [ "$distro" = "ubuntu" ] || [ "$distro" = "debian" ] || [ "$distro" = "kali" ]; then
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get install git wget build-essential -y
  sudo apt-get upgrade -y
  sudo apt-get update -y
elif [ "$distro" = "arch" ]; then
  echo y | sudo pacman -Syu git wget
else
  echo "Unknown linux distro"
fi

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile
brew install git wget

echo 'Done!'
