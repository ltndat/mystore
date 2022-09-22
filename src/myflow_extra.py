"""Base on python 3

Standalone, subcommmand support
Support all my method for my devflows
"""

MESSAGE = '[My Flow] script contains all methods for my devflows (require list modules)'


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
# ---------------------------------------------------------------------------------


# cli options methods -------------------------------------------------------------
def __options_help():
    from inspect import signature
    print('All methods support:\n')
    for _i in __cli_methods():
        print(f'{_i.__name__} {signature(_i)}')


Store = {
    'options': {
        '-h': __options_help,
        '--help': __options_help
    }
}
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
            Store['options'][ops]()
        except AttributeError:
            print(f'No option {fn}')
    elif len(args) > 0 or len(kwargs) > 0:
        fn, *args = args
        try:
            globals()[fn](*args, **kwargs)
        except AttributeError:
            print(f'No support method {fn}')
    else:
        print(f'message: {MESSAGE}')
# ---------------------------------------------------------------------------------


if __name__ == '__main__':
    args, kwargs = __parse_argv()
    __cli_app__(args, kwargs)
