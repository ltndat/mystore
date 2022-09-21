# Scoop
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

scoop install git sudo wget

# Chocolatety
sudo powershell -c "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; irm https://community.chocolatey.org/install.ps1 | iex; foreach ($i in $(curl.exe -s https://raw.githubusercontent.com/ltndat/mystore/main/src/choco_listapps.txt)) {choco install $i -y};"
