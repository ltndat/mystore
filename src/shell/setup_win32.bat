@REM Scoop
powershell -c "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"
powershell -c "irm get.scoop.sh | iex"

scoop install git
scoop bucket add main
scoop install sudo

@REM Chocolatety
sudo powershell -c ""Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'));""
