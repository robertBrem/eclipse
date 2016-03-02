# eclipse Docker Image

## Description
This docker image provides eclipse with additional plug-ins and lombok. It's based on [iwakoshi/eclipse](https://github.com/iwakoshi/eclipse). If you don't need plug-ins or lombok use [iwakoshi/eclipse](https://github.com/iwakoshi/eclipse) instead.  
If you use this image without rebuilding [subclipse](http://subclipse.tigris.org/) is the only plug-in that is installed. To use lombok or other plug-ins you have to rebuild the image.

## Usage
```bash
#!/bin/bash

docker stop eclipse && docker rm eclipse
xhost +local:eclipse
docker run -ti --rm --name eclipse -v /home/robert/Schreibtisch/trunk_workspace:/home/eclipse/workspace:rw \
 -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/robert/Schreibtisch/trunk:/home/eclipse/trunk:rw -e DISPLAY=unix$DISPLAY \
 robertbrem/eclipse --device /dev/snd
```
**IMPORTANT:** This will only add the [subclipse](http://subclipse.tigris.org/) plug-in.

### Use Lombok
```bash
docker build --tag=robertbrem/eclipseWithLombok --build-arg LOMBOK=1 .
```

### Add another plug-in
To add a new plug-in you have to know two parts.  
The **repositories** (yes, sometimes you have to add more than one repository to successfully resolve the dependencies) and  
the **plug-in name**.  
You have to change the `eclipseInput.json` file. If you have a look at this file you will notice that it is a json array in an array, literally a map. For each entry the `Dockerfile` calls an install plug-in command. An entry consists of the two already mentioned parts (repositories and plug-in name). The initial `eclipseInput.json` file from this repository contains the entries to use [subclipse](http://subclipse.tigris.org/). It needs this three plug-ins.

#### How to find out the repositories and the plug-in name
In the following i describe my way to find out the repositories and plug-in names. If you have a better solution please contact me or create a pull request.

##### Add plug-in in eclipse
Go to `Help - Eclipse Marketplace` and search for your plug-in. Then install it over the Marketplace.


## Tested with
* [subclipse](http://subclipse.tigris.org/)
 * http://subclipse.tigris.org/update_1.10.x : org.tigris.subversion.subclipse.feature.group
 * http://subclipse.tigris.org/update_1.10.x : org.tigris.subversion.clientadapter.feature.feature.group
 * http://subclipse.tigris.org/update_1.10.x : org.tigris.subversion.clientadapter.svnkit.feature.feature.group
* [Weblogic Tools](http://www.oracle.com/technetwork/developer-tools/eclipse/overview/weblogicservertools-161590.html)
 * http://download.oracle.com/otn_software/oepe/library/eclipse-sapphire-9.0.4,http://download.oracle.com/otn_software/oepe/library/jersey-1.17.1-p002,http://download.oracle.com/otn_software/oepe/library/jackson-1.9.13,http://download.oracle.com/otn_software/oepe/12.2.1.2/mars/repository : oracle.eclipse.tools.weblogic.feature.group

## FAQ
### Why do I have to rebuild the image and can't use environment variables on startup?
The installation especially the downloading of the plug-in can take very long. If you have to wait 30 or more minutes to start eclipse the image will be useless.
