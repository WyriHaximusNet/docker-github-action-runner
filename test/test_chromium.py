import pytest

def test_chromium(host):
    assert 'Chromium ' in host.run('chromium-browser --version').stdout
