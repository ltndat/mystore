if ($IsWindows) {
  Install-Module -Name Terminal-Icons -Repository PSGallery
  scoop bucket add main
  scoop install oh-my-posh fzf
  scoop update *
} else {
  foreach ($i in $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)) {iex $i}
  brew update
  brew install jandedobbeleer/oh-my-posh/oh-my-posh exa fzf
}

Install-Module -Name z
Install-Module PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module posh-git -Scope CurrentUser -Force
Install-Module PSFzf -Scope CurrentUser -Force
# Link config 
New-Item -Path $(Split-Path $PROFILE.CurrentUserCurrentHost -Parent) -ItemType "directory"
echo '. ~/.config/myshell/config.ps1' > $PROFILE.CurrentUserCurrentHost
echo 'config successfully!'
# python $PSScriptRoot/change_content.py $PROFILE.CurrentUserCurrentHost '. ~/.config/myshell/config.ps1'
pwsh
