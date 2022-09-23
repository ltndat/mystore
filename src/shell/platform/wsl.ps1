wget https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
./wsl_update_x64.msi
scoop install archlinux
wsl --set-default-version 2
wsl --set-version Arch 2
echo 'sudo pacman-key --init; sudo pacman-key --populate; sudo pacman -S archlinux-keyring; echo y | sudo pacman -Syu;' | wsl
# wsl --install -d ubuntu
