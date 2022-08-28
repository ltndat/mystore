"""Utils async for python
"""
from threading import Thread
from time import sleep


def asynchronous(fn=None):
    def deco(*args, **kwargs):
        th = Thread(target=fn, args=args, kwargs=kwargs)
        th.start()
        return th
    return deco


if __name__ == '__main__':
    def run(*args):
        print(args)

    asynchronous(lambda *a: [s=sleep(2), run(*a)])(3, 4, 5, 6, 8, 8)
    run(1, 2, 3, 45)
