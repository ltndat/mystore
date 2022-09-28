import pytest

from src.python.utils import file


def test_handle_file():
    assert 1 == 1


def test_file_text():
    file.Text.init('storage/text')
    print(file.Text.use('storage/text'))
