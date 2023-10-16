#!/bin/bash
# Shortcut to start Docker container via Podman-HPC on NERSC

OUTER_VNC_PORT=$RANDOM # Set to something that no one else is using.
USERNAME=$(whoami)
export VNC_PW="$(cat /dev/random | tr -dc "[0-9A-Za-z]" | head -c 20)"

cat << EOF
Setting up VNC server on node's port $OUTER_VNC_PORT. Forward a local port on your local computer to this port to connect to VNC.
Username is $USERNAME.
The VNC password is: $VNC_PW
Don't share it with others!
EOF

podman-hpc run -it --userns keep-id:uid=1000,gid=1000 -p $OUTER_VNC_PORT:5901 \
    -e DISPLAY \
    -e VNC_PW \
    -v "$(pwd -P $HOME):/home/$USERNAME" \
    -v $(readlink -f ~/.config):/headless/.config \
    -v $(readlink -f ~/.themes):/headless/.themes \
    -v $(readlink -f ~/.icons):/headless/.icons \
    -v /global:/global \
    -v /pscratch:/pscratch \
    docker://docker.io/samueldy/vnc-docker-debian-xfce4 $@ 
