import pytest

def test_terraform(host):
    assert 'Terraform v' in host.run('terraform version').stdout
    assert 'on linux_' in host.run('terraform version').stdout
