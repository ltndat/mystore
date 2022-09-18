"""High level api to handle file
"""
from os import makedirs, path
from codecs import decode


def handle_file(file_name='', mode='', encoding='utf-8', *args, **kwargs) -> None:
    """My handle file and folder `python.utils.file`
    base from `open` function

    Example:
    ```python
    handle_file(file_name, 'x')()
    handle_file(file_name, 'w')(lambda f: f.write(init_value))
    ```
    """
    def deco(handler=lambda *a: a, error_handler=lambda *a: a):
        """Callback function

        Example:
        ```python
        handler(file)
        error_handler(file_name, mode, encoding,handler)
        ```
        """
        try:
            f = open(file_name, mode, encoding=encoding, *args, **kwargs)
            handler(f)
            f.close()
        except Exception as _e:
            print(f'Warning: {str(_e)}')
            error_handler(file_name, mode, encoding, handler)
    return deco


def new_file(file_name=''):
    _f = path.dirname(file_name)
    if _f and not path.exists(_f):
        makedirs(path.dirname(file_name))
    handle_file(file_name, 'x')()


def new_folder(path_name=''):
    if not path.exists(path_name):
        makedirs(path_name)


def remove_file(file_name=''):
    if path.exists(file_name):
        from os import remove
        remove(file_name)


def remove_folder(path_name=''):
    if path.exists(path_name):
        from shutil import rmtree
        rmtree(path)


def copy_file(src=None, target=None):
    assert src is not None and target is not None
    if path.exists(src):
        from shutil import copyfile
        copyfile(src, target)


def copy_folder(src=None, target=None):
    assert src is not None and target is not None
    if path.exists(src):
        from shutil import copytree
        copytree(src, target)


def open_file(file_name='', init_value=''):
    """Open file and create it in nested folder if necessary `python.utils.file`

    Example:
    ```python
    Local = open_file(f'{FOLDER}/local.json')
    ```
    """
    if not path.exists(file_name):
        new_file(file_name)
        handle_file(file_name, 'w')(lambda f: f.write(init_value))

    result = {}

    @handle_file(file_name, 'r')
    def _fn(f):
        result['data'] = f.read()

    return result['data']


def replace_content(file_name=None, content=None):
    """Change file content

    Example:
    ```python
    change_content('tmp', 'hello world')
    ```
    """
    assert file_name != None and content != None
    content = decode(content, 'unicode_escape')
    if not path.exists(file_name):
        open_file(file_name, content)
    else:
        handle_file(file_name, 'w')(lambda f: f.write(content))
