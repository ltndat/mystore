$IsWsl = ($env:WSL_DISTRO_NAME -ne $null)

if ($IsWindows) {
  git clone https://github.com/ltndat/myshell.git $env:USERPROFILE/.config/myshell
  git clone https://github.com/ltndat/myapps.git $env:USERPROFILE/.config/myapps
  git clone https://github.com/ltndat/mystore.git $env:USERPROFILE/.config/mystore
  scoop bucket add main
  scoop bucket add extras
  scoop install wget msys2 sudo nodejs python vscode neovim
} else {
  foreach ($i in $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)) {iex $i}  
  brew install python node neovim
  if ($IsWsl -eq $false) { brew install --cask visual-studio-code }
  # set alias
  sudo ln -sf (which python3) /usr/local/bin/python
}

# python
pip install pipenv autopep8

# nodejs
if ($IsWindows) {
  npm -g install yarn
} else {
  sudo npm -g install yarn
}

# git
git config --global credential.helper store
