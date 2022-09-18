"""Base on python 3

Standalone, subcommmand support
Support all my method for my devflows
"""

API_NAME = 'myflow.py'


def file(method=None, *args, **kwargs):
    assert method is not None

    def get(key=None):
        assert key is not None

    try:
        print(locals()[method])
        locals()[method](*args, **kwargs)
    except KeyError as e:
        print(f'Not support method {str(e)}')


if __name__ == '__main__':
    from sys import argv
    if len(argv) > 1:
        _, fn, *args = argv
        try:
            globals()[fn](*args)
        except AttributeError as _e:
            print(str(_e))
    else:
        print(f'{API_NAME} API contains all methods for my devflows')
