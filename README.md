# Self hosted GitHub Action Runner Image

Opinionated GitHub Action Runner image that brings the ships the following packages:
* curl 
* wget 
* make 
* git 
* unzip 
* gnupg

Also includes the following tools:
* terraform
* AWS CLI (v2)

Also unlocks the installed tools in `/home/runner/.local/bin` by adding it into the `$PATH` environment variable.
