# eclipse Docker Image

## Description
This docker image provides eclipse with additional plug-ins and lombok.
It's based on [iwakoshi/eclipse](https://github.com/iwakoshi/eclipse).
If you don't need plug-ins or lombok use [iwakoshi/eclipse](https://github.com/iwakoshi/eclipse).

## Usage
```bash
#!/bin/bash

docker stop eclipse && docker rm eclipse
xhost +local:eclipse
docker run -ti --rm --name eclipse -v /home/robert/Schreibtisch/trunk_workspace:/home/eclipse/workspace:rw \
 -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/robert/Schreibtisch/trunk:/home/eclipse/trunk:rw -e DISPLAY=unix$DISPLAY \
 robertbrem/eclipse --device /dev/snd
```
