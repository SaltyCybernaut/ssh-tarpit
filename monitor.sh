#!/usr/bin/env sh

port='22'
sudo docker logs --follow ssh-tarpit-$port
