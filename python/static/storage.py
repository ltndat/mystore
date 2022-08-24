import json

from ..utils import file


data = {}


def init(file_name=None, default_value=None):
    """Storage local file
    
    Example:
    ```python
    test_data = ['storage/local.json', 'storage/process.json', 'storage/user.json']
    for i in test_data: storage.init(i, '{}') 
    ```
    """
    assert file_name != None and default_value != None
    f = file.open_file(file_name, default_value)
    data[file_name] = json.loads(f)


def save():
    for _key in data:
        _val = data[_key]
        file.handle_file(_key,
                         'w')(lambda f: f.write(json.dumps(_val)))


def get_db(file_name=None):
    assert file_name != None
    return data[file_name]
