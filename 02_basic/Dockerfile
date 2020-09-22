# Builds a ubuntu server that stays indefinitely.
# Search for image on dockerhub, and use the tags tab to search for specific
# versions.
FROM ubuntu:18.04

# ARG are variables only available during build.
ARG DEBIAN_FRONTEND=noninteractive
# ENV variables are available when the image is run.
ENV var1=1024
# This line allows the container to continue existing.
ENTRYPOINT ["tail", "-f", "/dev/null"]
