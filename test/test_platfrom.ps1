$IsWsl = ($env:WSL_DISTRO_NAME -ne $null)

if ($IsWindows) {
  echo 'Windows'
} else if ($IsMacOS) {
  echo 'Mac OS'
} else if ($IsWsl) {
  echo 'Wsl'
} else {
  echo 'Linux'
}
