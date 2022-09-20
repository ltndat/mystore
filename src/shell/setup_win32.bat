@REM Scoop
powershell -c "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"
powershell -c "irm get.scoop.sh | iex"

scoop install git
scoop bucket add main
scoop install sudo

@REM Chocolatety
sudo powershell -c "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;irm https://community.chocolatey.org/install.ps1 | iex; foreach ($i in $(curl.exe -s https://raw.githubusercontent.com/ltndat/mystore/main/src/choco_listapps.txt)) {choco install $i -y};"
