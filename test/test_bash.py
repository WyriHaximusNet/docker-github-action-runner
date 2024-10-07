import pytest

def test_bash_true_results_in_0(host):
    output = host.run('bash -c "true"')
    assert output.rc == 0

def test_bash_true_results_in_0(host):
    output = host.run('bash -c "false"')
    assert output.rc > 0
