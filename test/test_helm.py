import pytest

def test_helm(host):
    assert 'version.BuildInfo{Version:"v' in host.run('helm version').stdout
