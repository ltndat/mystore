$IsWsl = ($env:WSL_DISTRO_NAME -ne $null)

if ($IsWindows) {
  scoop install git wget
  scoop bucket add main
  scoop bucket add extras
  scoop install windows-terminal msys2 sudo nodejs python vscode neovim
} else {
  foreach ($i in $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)) {iex $i}  
  brew install git wget python node neovim
  sudo ln -sf (which python3) /usr/local/bin/python
  if ($IsWsl -eq $false) { brew install --cask visual-studio-code }
}

git config --global credential.helper store
