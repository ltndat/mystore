$IsWsl = ($env:WSL_DISTRO_NAME -ne $null)

if ($IsWindows) {
  echo 'Windows'
} elseif ($IsMacOS) {
  echo 'Mac OS'
} elseif ($IsWsl) {
  echo 'Wsl'
} else {
  echo 'Linux'
}
