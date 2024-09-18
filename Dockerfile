# syntax=docker/dockerfile:1
FROM ghcr.io/actions/actions-runner:latest

USER root

RUN (echo 'DPkg::Post-Invoke {"/bin/rm -f /var/cache/apt/archives/*.deb || true";};' | tee /etc/apt/apt.conf.d/clean) &&\
    apt-get update &&\
    apt-get upgrade -y &&\
    apt-get install -y curl wget make git unzip gnupg software-properties-common jq &&\
    ## TerraForm
    (wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor |  tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null) &&\
    gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint &&\
    (echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list) &&\
    apt-get update &&\
    apt-get install -y terraform &&\
    ## AWS CLI
    curl "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o "/tmp/awscliv2.zip" &&\
    unzip /tmp/awscliv2.zip &&\
    ./aws/install &&\
    rm /tmp/* -Rf &&\
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 &&\
    chmod 700 get_helm.sh &&\
    ./get_helm.sh &&\
    rm ./get_helm.sh

## See https://github.com/actions/checkout/issues/956
RUN groupmod -g 1000 runner && usermod -u 1000 runner

USER runner

# Make sure default installed node available for use
ENV PATH="/home/runner/externals/node20/bin/:$PATH"
