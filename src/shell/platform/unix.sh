sudo echo 'Begin'

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

distro=$(awk -F = '/^ID=/ {print $2}' /etc/os-release)
UNAME=$(uname)

# if [ "$UNAME" == "Linux" ] ; then
# 	echo "Linux"
# elif [ "$UNAME" == "Darwin" ] ; then
# 	echo "Darwin"
# elif [[ "$UNAME" == CYGWIN* || "$UNAME" == MINGW* ]] ; then
# 	echo "Windows"
# fi

if [ "$distro" = "ubuntu" ] || [ "$distro" = "debian" ]; then
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get install build-essential -y
  sudo apt-get upgrade -y
  sudo apt-get update -y
elif [ "$distro" = "$arch" ]; then
  sudo pacman-key --init
  sudo pacman-key --populate
  sudo pacman -S archlinux-keyring
  echo y | sudo pacman -Syu
else
  echo "Unknown linux distro"
fi

echo 'Done!'
