"""Json file handle, support cli and standalone
"""
import json as parser
from os import path


C = 'create'
R = 'get'
U = 'edit'
D = 'delete'


def get(file_name=None, key=None):
    assert path.exists(file_name)
    assert key is not None


def create(): pass
def edit(): pass
def delete(): pass


if __name__ == '__main__':
    from sys import argv
    from os import path

    if len(argv) > 1:
        _, fn, *args = argv
        try:
            globals()[fn](*args)
        except AttributeError as _e:
            print(str(_e))
    else:
        print(f'{path.basename(__file__)} API')
