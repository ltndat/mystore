import time
import sys

for i in range(100):
    time.sleep(0.01)
    sys.stdout.write(f'{i}')
    # sys.stdout.write("\r%d%%" % i)
    sys.stdout.flush()
