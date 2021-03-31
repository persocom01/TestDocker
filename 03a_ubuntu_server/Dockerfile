# Builds a ubuntu server that stays indefinitely.
FROM ubuntu:18.04

RUN apt-get update
RUN apt-get -y upgrade

# Set the locale
RUN apt-get -y install locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get -y install python3-dev
RUN apt-get -y install python3-pip
RUN pip3 install -U pip

# If using venv:
# RUN apt-get -y install python3-venv
# ENV VIRTUAL_ENV=./myenv
# RUN python3 -m venv $VIRTUAL_ENV
# ENV PATH="$VIRTUAL_ENV/bin:$PATH"
# RUN pip install -U pip

# If you don't wish to change the ENV variable:
# RUN . $VIRTUAL_ENV/bin/activate && pip install -U pip

ENTRYPOINT ["tail", "-f", "/dev/null"]
