#!/bin/bash
# Shortcut to start Docker container via Podman-HPC on NERSC

    # -e 'VNC_PORT=57868' \
    # --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
    # --net host \
OUTER_VNC_PORT=24835 # Set to somethign that no one else is using.

podman-hpc run -it --userns keep-id:uid=1000,gid=1000 -p $OUTER_VNC_PORT:5901 \
    -e DISPLAY \
    -v /global/u2/s/samueldy:/home/samueldy \
    -v $(readlink -f ~/.config):/headless/.config \
    -v $(readlink -f ~/.themes):/headless/.themes \
    -v $(readlink -f ~/.icons):/headless/.icons \
    -v /global:/global \
    -v /pscratch:/pscratch \
    registry.nersc.gov/m4357/samueldy-vnc-docker-ubuntu $@ 
