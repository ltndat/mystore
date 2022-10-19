[CmdletBinding()]
param (
  [string]$distro = 'arch'
)

wsl --update

echo 'Default distro [arch linux]'
try {
  if ($distro -eq "arch") {
    scoop bucket add extras
    scoop install archwsl
  } else {
    wsl --install -d $distro
  }
} catch {
  echo "Not found distro $distro"
  return
}

wsl --set-default-version 2
wsl --set-version $distro 2
wsl --set-default $distro

# wsl -d $distro | curl.exe -fsSL https://raw.githubusercontent.com/ltndat/mystore/main/src/shell/platform/wsl.sh
