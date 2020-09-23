# Test file.
FROM ubuntu:18.04

ENV DISPLAY=host.docker.internal:0
ADD AstraSDK-v2.1.1-24f74b8b15-20200426T014025Z-Ubuntu18.04-x86_64.tar.gz /
RUN apt-get update
RUN apt-get -y install cmake
RUN apt-get -y install libsfml-dev
RUN apt-get -y install pkg-config
RUN apt-get install libusb-1.0-0
WORKDIR /AstraSDK-v2.1.1-24f74b8b15-20200426T014025Z-Ubuntu18.04-x86_64/samples
RUN cmake .
RUN make
WORKDIR bin
ENTRYPOINT ["tail", "-f", "/dev/null"]
CMD ./SimpleBodyViewer-SFML
