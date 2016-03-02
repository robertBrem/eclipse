FROM iwakoshi/eclipse

MAINTAINER Robert Brem <brem_robert@ĥotmail.com>

USER root

ARG LOMBOK

RUN apt-get update \
&& apt-get install curl libcanberra-gtk-module -y

WORKDIR /opt/eclipse

USER eclipse

ADD installPlugins.js /opt/eclipse/
ADD eclipseInput.json /opt/eclipse/
RUN ./installPlugins.js

USER root
RUN apt-get purge -y curl \
&& apt-get autoremove -y && \
apt-get -y clean && rm -rf /var/lib/apt/lists/*
USER eclipse
