import pytest

def test_terraform(host):
    assert 'Hello from Docker!' in host.run('docker run hello-world').stdout
    assert 'This message shows that your installation appears to be working correctly.' in host.run('docker run hello-world').stdout
