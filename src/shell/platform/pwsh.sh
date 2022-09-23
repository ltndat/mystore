# get su permission
sudo echo 'Begin'

distro=$(awk -F = '/^ID=/ {print $2}' /etc/os-release)
UNAME=$(uname)

if [ "$UNAME" == "Darwin" ] ; then
	brew install --cask powershell
# elif [ "$distro" = "ubuntu" ]; then
#   sudo apt-get update
#   sudo apt-get install -y wget apt-transport-https software-properties-common
#   wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
#   sudo dpkg -i packages-microsoft-prod.deb
#   sudo apt-get update
#   sudo apt-get install -y powershell
# elif [ "$distro" = "debian" ]; then
#   sudo apt update  && sudo apt install -y curl gnupg apt-transport-https
#   curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
#   sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-bullseye-prod bullseye main" > /etc/apt/sources.list.d/microsoft.list'
#   sudo apt update && sudo apt install -y powershell
elif [ "$distro" = "arch" ]; then
  sudo pacman -Syy
  cd ~
  git clone https://aur.archlinux.org/powershell-bin.git
  cd powershell-bin
  makepkg -si
  cd ..
  rm -rf powershell-bin
# elif [ "$distro" = "kali" ]; then
else
  wget https://aka.ms/install-powershell.sh; sudo bash install-powershell.sh; rm install-powershell.sh
fi


echo 'Done!'
echo 'Update-Module; Get-Module' | pwsh
