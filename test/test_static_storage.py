# import pytest
# import os
# import shutil

# from python.static import storage

# test_data = ['storage/local.json', 'storage/process.json', 'storage/user.json']


# def test_init():
#     for i in test_data:
#         storage.init(i, '{}')
#     for i in test_data:
#         assert os.path.exists(i)


# def test_apply_data():
#     db = storage.get_db('storage/process.json')
#     db['pid'] = os.getpid()
#     storage.save()

#     db = storage.get_db('storage/process.json')
#     assert db['pid'] == os.getpid()


# def test_cleanup():
#     shutil.rmtree('storage')
