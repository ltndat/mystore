[CmdletBinding()]
param (
  [string]$app_dir
)

if ($app_dir -eq "") {
  echo 'message: input your vscode location!'
  return
}

# link folder vscode to myapps
rm -r -fo $app_dir/User
ln "$env:HOME/.config/myapps/vscode" "$app_dir/User"

# install extensions
foreach ($i in $(cat $env:HOME/.config/myapps/vscode/extensions.json | ConvertFrom-Json)) 
{code --install-extension $i}
