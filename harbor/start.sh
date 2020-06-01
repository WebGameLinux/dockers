#!/bin/bash

version="v2.0.0"

wget https://github.com/goharbor/harbor/releases/download/${version}/harbor-offline-installer-${version}.tgz

tar -zxf  harbor-offline-installer-${version}.tgz

cd harbor

./install.sh