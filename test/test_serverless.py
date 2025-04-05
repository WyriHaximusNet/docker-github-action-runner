import pytest

def test_helm(host):
    assert 'Serverless ϟ Framework 4.' in host.run('serverless -v').stdout
