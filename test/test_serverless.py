import pytest

def test_serverless(host):
    assert 'osls version: 3.' in host.run('serverless --version').stdout
