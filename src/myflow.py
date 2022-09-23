"""Base on python 3

Standalone, subcommmand support
Support all my method for my devflows
"""

MESSAGE = '[My Flow] script contains all methods for my devflows (no require modules)'


# Utils ---------------------------------------------------------------------------
def __parse_argv():
    from sys import argv

    args = []
    kwargs = {}
    _, *string = argv
    for _i in string:
        if '=' in _i:
            _k, _v = _i.split('=')
            kwargs[_k] = _v
        else:
            args.append(_i)
    return args, kwargs


def __format_stdout(label='Stdout', data=None):
    assert data is not None
    return f'--------------------------------------------\n{label}\n--------------------------------------------\n{data}'


def __parse_process_syntax(cmds):
    result = [i.strip() for i in ''.join(cmds).split(';') if i.strip()]
    print(result)
    return result


def __parse_stdout(b):
    return b.decode("utf-8")


def __handle_file(file_path='', mode='', encoding='utf-8', *args, **kwargs) -> None:
    """My handle file and folder `python.utils.file`
    base from `open` function

    Example:
    ```python
    __handle_file(file_path, 'x')()
    __handle_file(file_path, 'w')(lambda f: f.write(init_value))
    ```
    """
    def deco(handler=lambda *a: a, error_handler=lambda *a: a):
        """Callback function

        Example:
        ```python
        handler(file)
        error_handler(file_path, mode, encoding,handler)
        ```
        """
        try:
            f = open(file_path, mode, encoding=encoding, *args, **kwargs)
            handler(f)
            f.close()
        except Exception as _e:
            print(f'Warning: {str(_e)}')
            error_handler(file_path, mode, encoding, handler)
    return deco
# ---------------------------------------------------------------------------------


# cli options methods -------------------------------------------------------------
def __options_help():
    from inspect import signature
    std = ''
    for _i in __cli_methods():
        name = _i.__name__
        while len(name) < 24:
            name += ' '
        std += f'{name} << {signature(_i)}\n'
    print(__format_stdout('All methods support:', std))
# ---------------------------------------------------------------------------------


# cli main methods ----------------------------------------------------------------
def open_file(file_path=None, init_value=''):
    """Open file and create it in nested folder if necessary `python.utils.file`

    Example:
    ```python
    Local = open_file(f'{FOLDER}/local.json')
    ```
    """
    assert file_path is not None

    from os import path
    if not path.exists(file_path):
        new_file(file_path)
        __handle_file(file_path, 'w')(lambda f: f.write(init_value))

    result = {}

    @__handle_file(file_path, 'r')
    def _fn(f): result['data'] = f.read()

    return result['data']


def new_file(file_path=None):
    assert file_path is not None

    from os import path, makedirs
    _f = path.dirname(file_path)
    if _f and not path.exists(_f):
        makedirs(path.dirname(file_path))
    __handle_file(file_path, 'x')()


def new_folder(dir_path=None):
    assert dir_path is not None

    from os import path, makedirs
    if not path.exists(dir_path):
        makedirs(dir_path)


def remove_file(file_path=None):
    assert file_path is not None

    from os import path
    if path.exists(file_path):
        from os import remove
        remove(file_path)


def remove_folder(dir_path=None):
    assert dir_path is not None

    from os import path
    if path.exists(dir_path):
        from shutil import rmtree
        rmtree(path)


def copy_file(file_path=None, target=None):
    assert file_path is not None and target is not None
    from os import path
    if path.exists(file_path):
        from shutil import copyfile
        copyfile(file_path, target)


def copy_folder(src=None, target=None):
    assert src is not None and target is not None
    from os import path
    if path.exists(src):
        from shutil import copytree
        copytree(src, target)


def edit_file(file_path=None, content=None):
    """Edit file content

    Example:
    ```python
    edit_file('tmp', 'hello world')
    ```
    """
    assert file_path != None and content != None
    from os import path
    from codecs import decode
    content = decode(content, 'unicode_escape')
    if not path.exists(file_path):
        open_file(file_path, content)
    else:
        __handle_file(file_path, 'w')(lambda f: f.write(content))


def process_sequence(*cmds):
    assert len(cmds) > 0
    cmds = __parse_process_syntax(cmds)
    assert len(cmds) > 0
    import subprocess

    for i, cmd in enumerate(cmds):
        cmd = cmd.split(' ')
        process = subprocess.Popen(
            cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
        out, err = process.communicate()
        out and print(__format_stdout(
            f'Process [{i + 1}]:[{cmd[0]}]', __parse_stdout(out)))
        err and print(__format_stdout(
            f'Process [{i + 1}]:[{cmd[0]}]', __parse_stdout(err)))
        process.wait()


def process_parallel(*cmds):
    assert len(cmds) > 0
    cmds = __parse_process_syntax(cmds)
    assert len(cmds) > 0
    import subprocess
    from threading import Thread
    from time import sleep
    import sys

    store = []

    def run(i, cmd):
        is_done = False

        def fn():
            while not is_done:
                print(f'>> ...[{i + 1}]:[{cmd[0]}]... <<')
                # sys.stdout.write('.')
                # sys.stdout.flush()
                sleep(0.5)
        cmd = cmd.split(' ')
        process = subprocess.Popen(
            cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
        th = Thread(target=fn)
        th.start()
        out, err = process.communicate()
        out and print(__format_stdout(
            f'Process [{i + 1}]:[{cmd[0]}]', __parse_stdout(out)))
        err and print(__format_stdout(
            f'Process [{i + 1}]:[{cmd[0]}]', __parse_stdout(err)))

        process.wait()
        is_done = True
        th.join()

    for i, cmd in enumerate(cmds):
        th = Thread(target=run, args=(i, cmd,))
        store.append(th)
        th.start()

    for th in store:
        th.join()


def process_exit(pid=None):
    assert pid is not None

    from signal import SIGKILL
    from os import kill
    try:
        kill(pid, SIGKILL)
    except Exception as _e:
        print(str(_e))


def file(method=None, *args, **kwargs):
    assert method is not None

    try:
        return locals()[method](*args, **kwargs)
    except KeyError as e:
        print(f'Not support method {str(e)}')

# ---------------------------------------------------------------------------------


# CLi app @index ------------------------------------------------------------------
def __cli_parse_argv(args, kwargs):
    options = None
    for _i in args:
        if _i.startswith('-'):
            options = _i
            args.remove(_i)
            break

    return args, kwargs, options


def __cli_methods():
    # return [_i for _i in globals() if not _i.startswith('_')]
    result = []
    _globals = globals()
    for _i in _globals:
        if not _i.startswith('_') and callable(_globals[_i]):
            result.append(_globals[_i])
    return result


def __cli_app__(args, kwargs):
    args, kwargs, ops = __cli_parse_argv(args, kwargs)
    if ops is not None:
        try:
            output = Store['options'][ops]()
        except AttributeError:
            print(f'No option {fn}')
    elif len(args) > 0 or len(kwargs) > 0:
        fn, *args = args
        try:
            output = globals()[fn](*args, **kwargs)
        except AttributeError:
            print(f'No support method {fn}')
    else:
        output = f'message: {MESSAGE}'
    output and print(output)


Store = {
    'options': {
        '--help': __options_help
    },
}
# ---------------------------------------------------------------------------------


if __name__ == '__main__':
    args, kwargs = __parse_argv()
    __cli_app__(args, kwargs)
