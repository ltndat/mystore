from src.python.utils import storage

storage.init([
    'settings',
    'session',
    'argv'
], storage.TYPE_JSON)

storage.init([
    'user',
    {storage.INIT_NAME: 'settings.new', storage.INIT_EXT: '.js'},
    'argv',
    'session'
], storage.TYPE_TEXT)
print(storage.use(lambda state: state[storage.ROOT][storage.TYPE_JSON]))
