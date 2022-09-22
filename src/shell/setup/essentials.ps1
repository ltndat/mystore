$IsWsl = ($env:WSL_DISTRO_NAME -ne $null)

function setup_runtime {
  if ($IsWindows) {
    scoop bucket add extras
    scoop install msys2 sudo nodejs python vscode neovim
  } else {
    foreach ($i in $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)) {iex $i}  
    brew install python node neovim
    if ($IsMacOS) {
      brew install --cask visual-studio-code 
    }
    # set alias
    sudo ln -sf (which python3) /usr/local/bin/python
  }
}

function setup_apps {
  # python
  pip install pipenv

  # nodejs
  if ($IsWindows) {
    npm -g install yarn
  } else {
    sudo npm -g install yarn
  }

  # git
  git config --global credential.helper store
}

function setup_pwsh {
  # pwsh
  if ($IsWindows) {
    Install-Module -Name Terminal-Icons -Repository PSGallery
    scoop install oh-my-posh fzf
    git clone https://github.com/ltndat/myshell.git $env:USERPROFILE/.config/myshell
    git clone https://github.com/ltndat/myapps.git $env:USERPROFILE/.config/myapps
    git clone https://github.com/ltndat/mystore.git $env:USERPROFILE/.config/mystore
  } else {
    foreach ($i in $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)) {iex $i}
    brew update
    brew install jandedobbeleer/oh-my-posh/oh-my-posh exa fzf
    git clone https://github.com/ltndat/myshell.git ~/.config/myshell
    git clone https://github.com/ltndat/myapps.git ~/.config/myapps
    git clone https://github.com/ltndat/mystore.git ~/.config/mystore
  }

  Install-Module -Name z
  Install-Module PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
  Install-Module posh-git -Scope CurrentUser -Force
  Install-Module PSFzf -Scope CurrentUser -Force
  # Link config 
  New-Item -Path $(Split-Path $PROFILE.CurrentUserCurrentHost -Parent) -ItemType "directory"
  echo '. ~/.config/myshell/config.ps1' > $PROFILE.CurrentUserCurrentHost
  # python $PSScriptRoot/change_content.py $PROFILE.CurrentUserCurrentHost '. ~/.config/myshell/config.ps1'
}

setup_runtime
setup_apps
setup_pwsh

echo 'Successfully run `pwsh` to refresh and enjoy'
