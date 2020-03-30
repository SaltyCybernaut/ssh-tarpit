# Introduction

Are you tired of having your server logs cluttered with failed SSH login attempts from script kiddies? Would you like to enact some petty revenge again those ne'er-do-wells? If you answered yes, then you are in the right place. [Christopher Wellons](https://github.com/skeeto) graciously created a tiny C program that pretends to be a SSH server which takes advantage of the fact that SSH banners have no size limit in the SSH specification. This allows the server to send an endless stream of bytes as the banner and the client waits indefinitely for the server to finish. I have taken Chris' work and make it into a docker container for easy deployment.

## Getting Started

### Step 0 - [install docker](https://docs.docker.com/install)

### Step 1 - [change your real ssh server to a non-standard port](https://man.openbsd.org/sshd#p)

### Step 2 - get these delicious bits on your computer
```bash
git clone --branch v1.1 --recurse-submodules https://github.com/SaltyCybernaut/ssh-tarpit.git
cd ssh-tarpit
```

### Step 3 - build
```bash
./build.sh
```

### Step 4 - test on localhost
```bash
# open a second terminal and execute
./deploy.sh 127.0.0.1 2222 dev ssh-tarpit-dev
  
# back in the first terminal execute
ssh -p 2222 localhost

# stop docker container
sudo docker stop ssh-tarpit-dev-2222
```

### Step 5 - deploy in production
```bash
# listen on all addresses and standard port
port='22'
./deploy.sh

# or
# listen on a single address and standard port
address='10.0.0.1'
./deploy.sh $address

# or
# listen on a single address and non-standard port
address='10.0.0.1'
port='1234'
./deploy.sh $address $port

# or
# different container name
address='10.0.0.1'
port='22'
mode='prod'
name='new-name'
./deploy.sh $address $port $mode $name

# stop docker container
sudo docker stop ssh-tarpit-$port
sudo docker rm ssh-tarpit-$port
```

## Monitoring
`./monitor.sh`

## Resources
1. [Chris Wellons' blog about it](https://nullprogram.com/blog/2019/03/22)
2. [BSD Now comentary about how it works](https://www.youtube.com/embed/bM65iyRRW0A?start=232&end=563)
3. [endlessh repo](https://github.com/skeeto/endlessh)
