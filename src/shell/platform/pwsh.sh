# get su permission
sudo echo 'Begin'

distro=$(awk -F = '/^ID=/ {print $2}' /etc/os-release)
UNAME=$(uname)

if [ "$UNAME" == "Darwin" ] ; then
	brew install --cask powershell
elif [ "$UNAME" == "Linux" ] ; then
  sudo snap install powershell --classic
fi

echo 'Update-Module; Get-Module' | pwsh
