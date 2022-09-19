if ($IsWindows) {
  # setup plugin mananger for neovim
  git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"

  # remote config
  rm $env:LOCALAPPDATA\nvim
  ln "$env:USERPROFILE\.config\myapps\nvim" "$env:LOCALAPPDATA\nvim"
} else {
  git clone --depth 1 https://github.com/wbthomason/packer.nvim\
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim

  # remote config
  rm -f ~/.config/nvim
  ln ~/.config/myapps/nvim ~/.config/nvim
}
