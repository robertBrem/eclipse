FROM iwakoshi/eclipse

MAINTAINER Robert Brem <brem_robert@ĥotmail.com>

USER root

RUN apt-get update \
&& apt-get install curl libcanberra-gtk-module -y

WORKDIR /opt/eclipse

USER eclipse

ADD installPlugins.js /opt/eclipse/
ADD eclipseInput.json /opt/eclipse/
RUN ./installPlugins.js

RUN curl -O https://projectlombok.org/downloads/lombok.jar
RUN echo "-javaagent:/opt/eclipse/lombok.jar" >> eclipse.ini

USER root
RUN apt-get purge -y curl && apt-get autoremove -y && apt-get -y clean && rm -rf /var/lib/apt/lists/*
USER eclipse

WORKDIR ~/
