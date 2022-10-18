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

wget.exe 'https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi'
./wsl_update_x64.msi
rm ./wsl_update_x64.msi

wsl --set-default-version 2
wsl --set-version $distro 2
wsl --set-default $distro

wsl
