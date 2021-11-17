#!/usr/bin/env bash

{
  centos8=$(curl -s https://app.vagrantup.com/api/v1/box/corbolj/centos-8 | jq .)
  centos8=$(echo $centos8 | jq '.current_version.version') && centos8=$(sed -e 's/^"//' -e 's/"$//' <<< $centos8)
  major_version=$(echo $centos8 | cut -d'.' -f1)
  minor_version=$(echo $centos8 | cut -d'.' -f2)
  incremental_version=$(echo $centos8 | cut -d'.' -f3)
  new_incremental_version=$(($incremental_version+1))
  new_version="${major_version}.${minor_version}.${new_incremental_version}"
  packer.exe build -var "version=$new_version" ./
  vagrant box update
}
