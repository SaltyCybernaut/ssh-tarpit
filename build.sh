#!/usr/bin/env sh

version='1.0'

git submodule init
git submodule update
git -C endlessh checkout $version
sudo docker build --tag="endlessh:$version" endlessh/
