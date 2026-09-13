import pytest

def test_kubectl(host):
    assert 'Client Version: v' in host.run('kubectl version --client').stdout
