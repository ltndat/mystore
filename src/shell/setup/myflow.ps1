$store = "https://raw.githubusercontent.com/ltndat/mystore/main/src"

function get_list ($host_file) {
  return $(curl -fsSL $host_file | Join-String -Separator ' ')
}

pip install $(get_list "$store/static/myflow_listmodules.txt")
