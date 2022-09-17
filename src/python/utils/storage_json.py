import json

from . import file

INIT_VALUE = 0
FILE_NAME = 1
data = {}


def init_file(file_name=None, default_value={}):
    """Storage local file json

    Example:
    ```python
    test_data = 'storage/local'
    storage.init_file(i, '{}') 
    ```
    """
    assert file_name != None and default_value != None
    f = file.open_file(f'{file_name}.json', json.dumps(default_value))
    data[file_name] = json.loads(f)


def save(file_name=None):
    if file_name is None:
        file.handle_file(f'{file_name}.json',
                         'w')(lambda f: f.write(json.dumps(data[file_name])))
    else:
        for _key in data:
            _val = data[_key]
            file.handle_file(f'{_key}.json',
                             'w')(lambda f: f.write(json.dumps(_val)))


def collection(file_name=None):
    assert file_name != None
    return data[file_name]


def init(collections=[]):
    """Storage init collections with options

    Example:
    ```python
    collections = [
        {storage.FILE_NAME: 'storage/session', storage.INIT_VALUE: {'pid': os.getpid()}},
        {storage.FILE_NAME: 'storage/settings', storage.INIT_VALUE: {}},
        {storage.FILE_NAME: 'storage/database', storage.INIT_VALUE: []},
    ]
    storage.init(collections)
    ```
    """
    for collection in collections:
        assert FILE_NAME in collection
        _f = collection[FILE_NAME]
        _v = collection[INIT_VALUE] if INIT_VALUE in collection else {}
        init_file(_f, _v)
