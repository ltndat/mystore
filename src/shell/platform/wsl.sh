distro=$(awk -F = '/^ID=/ {print $2}' /etc/os-release)
UNAME=$(uname)

sudo echo 'First set up...'

# add default user
read -p "New username: " username
sudo echo "" >> /etc/wsl.conf
sudo echo "[user]" >> /etc/wsl.conf
sudo echo "default=$username" >> /etc/wsl.conf
sudo echo "$username ALL=(ALL) ALL" >> /etc/sudoers
sudo useradd -m $username
sudo passwd $username
 
if [ "$distro" = "ubuntu" ] || [ "$distro" = "debian" ] || [ "$distro" = "kali" ]; then
  echo '' 
elif [ "$distro" = "arch" ]; then
  is_error="true"
  while [ "$is_error" = "true" ]
  do
    {
      sudo pacman-key --init && sudo pacman-key --populate archlinux && sudo pacman -S archlinux-keyring --noconfirm && sudo pacman -Su --noconfirm && is_error="false"
    } || {
      is_error="true"
    }
  done
else
  echo "Unknown linux distro"
fi

exit
