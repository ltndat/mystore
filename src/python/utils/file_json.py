"""Json file handle, support cli and standalone
"""
import json as parser


def Json(file_name=None, method=R, *args, **kwargs):
    assert file_name != None and path.exists(file_name)
    import json as handler

    def get(key=None):
        assert key is not None

    def create(): pass
    def edit(): pass
    def delete(): pass

    try:
        print(locals()[method])
        locals()[method](*args, **kwargs)
    except KeyError as e:
        print(f'Not support method {str(e)}')


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
