import pytest

def test_aws(host):
    assert 'aws-cli/' in host.run('aws --version').stdout
