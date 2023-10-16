#!/bin/bash
# Shortcut to start Thunar via Podman-HPC on NERSC

USERNAME=$(whoami)

cat << EOF
Starting Thunar file manager on host's X server.
Username is $USERNAME.
EOF

podman-hpc run -it --userns keep-id:uid=1000,gid=1000 -p $OUTER_VNC_PORT:5901 \
    -e DISPLAY \
    -v "$(pwd -P $HOME):/home/$USERNAME" \
    -v $(readlink -f ~/.config):/headless/.config \
    -v $(readlink -f ~/.themes):/headless/.themes \
    -v $(readlink -f ~/.icons):/headless/.icons \
    -v "$HOME/.Xauthority:/headless/.Xauthority:rw" \
    -v /tmp:/tmp \
    -v /global:/global \
    -v /pscratch:/pscratch \
    docker://docker.io/samueldy/vnc-docker-debian-xfce4 --skip thunar
