from os import makedirs, path


def handle_file(file_name='', mode='', encoding='utf-8', *args, **kwargs) -> None:
    """My handle file and folder `python.utils.file`
    base from `open` function

    Example:
    ```python
    handle_file(file_name, 'x')()
    handle_file(file_name, 'w')(lambda f: f.write(default_value))
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


def open_file(file_name='', default_value=''):
    """Open file and create it in nested folder if necessary `python.utils.file`

    Example:
    ```python
    Local = open_file(f'{FOLDER}/local.json')
    ```
    """
    if not path.exists(file_name):
        new_file(file_name)
        handle_file(file_name, 'w')(lambda f: f.write(default_value))

    result = {}

    @handle_file(file_name, 'r')
    def _fn(f):
        result['data'] = f.read()

    return result['data']