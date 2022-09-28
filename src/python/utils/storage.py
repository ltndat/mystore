from os import path

from . import file

ROOT = 'storage'
REGISTER = []
TYPE_TEXT, TYPE_JSON, TYPE_TOML, TYPE_INI, TYPE_YAML, TYPE_XML = (
    'Text', 'Json', 'Toml', 'Ini', 'Yaml', 'Xml')
INIT_NAME, INIT_VALUE, INIT_EXT = ('file_path', 'init_value', 'ext')

data = {}


def use(callback=lambda state: state):
    """Use data in storage and save if change data

    Example:
    ```python
    print(storage.use(lambda state: state['storage'][storage.TYPE_JSON]))
    ```
    """
    return callback(data)


def init(file_list: list, type=TYPE_TEXT, folder_name=ROOT):
    """Init folder storage management

    Example:
    ```python
    storage.init([
        'user',
        {storage.INIT_NAME: 'settings.new', storage.INIT_EXT: '.js'},
        'argv',
        'session'
    ], storage.TYPE_TEXT)
    ```
    """
    try:
        parser = getattr(file, type)
    except AttributeError:
        raise Exception(f'Type file ({type}) not supported')

    if folder_name not in data:
        data[folder_name] = {}
    if type not in data[folder_name]:
        data[folder_name][type] = {}
    for fp in file_list:
        if not isinstance(fp, dict):
            id = fp
            fp = {INIT_NAME: fp}
        else:
            id = fp[INIT_NAME]
        fp[INIT_NAME] = path.join(folder_name, *fp[INIT_NAME].split('.'))

        try:
            data[folder_name][type][id] = parser(**fp)
        except Exception as e:
            print(str(e))
    if folder_name != ROOT:
        REGISTER.append(folder_name)
