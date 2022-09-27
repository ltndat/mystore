[CmdletBinding()]
param (
  [string]$distro = 'arch'
)

wsl --update

echo 'Default distro [arch linux]'
try {
  if ($distro -eq "arch") {
    scoop install archlinux
  } else {
    wsl --install -d $distro
  }
} catch {
  echo "Not found distro $distro"
  return
}

wsl --set-default-version 2
wsl --set-version $distro 2
wsl --set-default $distro

# wget https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
# ./wsl_update_x64.msi
# rm ./wsl_update_x64.msi

# add default user
start wsl -Wait 'read -p "New username:" username; sudo echo "" >> /etc/wsl.conf; sudo echo "[user]" >> /etc/wsl.conf; sudo echo "default=$username" >> /etc/wsl.conf; sudo echo "$username ALL=(ALL) ALL" >> /etc/sudoers; sudo useradd -m $username; sudo passwd $username; exit' 
wsl --shutdown
