import pytest

def test_user_app(host):
    userName = 'runner'
    groupName = 'runner'
    homeDir = '/home/runner'

    usr = host.user(userName)
    assert userName in usr.name
    assert groupName in usr.group
    assert homeDir in usr.home
