import pytest

def test_node20(host):
    assert 'v20.' in host.run('node -v').stdout
