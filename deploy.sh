#!/usr/bin/env bash

version='1.1'

# listen on all addresses
address=''

# listen on user specified address
if [ "$1" != '' ]; then
    address="$1"
fi

# listen on standard port
port='22'

# listen on a non-standard port
if [ "$2" != '' ]; then
    port="$2"
fi

# default type of container
mode='prod'

# user specified type of container
if [ "$3" != '' ]; then
    mode="$3"
fi
if [ "$mode" == 'prod' ]; then # set flages for production mode
    flags='--restart always --detach=true'
elif [ "$mode" == 'dev' ]; then # set flags for development mode
    flags='--rm'
else
    echo "unrecognized mode '$mode' (3th argument), valid options are 'prod' and 'dev'"
    exit 1
fi

# default name
name='ssh-tarpit'

# user specified name
if [ "$4" != '' ]; then
    name="$4"
fi

# listen on specified adress and port, allow read only access to configuration file stored on the host.
# prod
sudo docker run $flags --name="$name-$port"  --volume=$(pwd)/endlessh.conf:/etc/endlessh/config:ro --publish $address:$port:2222 endlessh:$version
