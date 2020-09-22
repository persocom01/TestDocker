# Demonstrates building a webserver using docker.
FROM ubuntu

# Prevents prompts from appearing.
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y apache2
RUN apt-get install -y apache2-utils
RUN apt-get clean
# Exposes port 80 of the container.
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
