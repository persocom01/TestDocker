# Demonstrates a containerized linux desktop app.
FROM ubuntu:18.04

# Allows the container to communicate with the host windows XServer.
ENV DISPLAY=host.docker.internal:0

# This line allows the container to continue existing.
ENTRYPOINT ["tail", "-f", "/dev/null"]
