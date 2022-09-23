[CmdletBinding()]
param (
  [string]$app_dir
)

if ($app_dir -eq "") {
  echo 'message: input your windows-terminal location!'
  return
}

# link folder vscode to myapps
rm -rf $app_dir/LocalState
ln "$env:HOME/.config/myapps/wt" "$app_dir/LocalState"
