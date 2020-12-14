# TestDocker

A docker testing playground based on: https://www.tutorialspoint.com/docker/index.htm

In order to upload and download docker images, you will almost most likely be using dockerhub, and an account on the site, which can be found at: https://hub.docker.com/

## Installation

Depending on the operating system, docker is installed in different ways.

### Windows

The windows version of docker can easily be installed using the installer, which can be downloaded here: https://hub.docker.com/editions/community/docker-ce-desktop-windows/

In order to run containerized desktop linux applications on windows, there is also a need to install and run XServer, which is part of every linux desktop environment. Get it here: https://sourceforge.net/projects/vcxsrv/

To make windows XServer communicate with the container, use the following command:

```
docker run -e DISPLAY=host.docker.internal:0 image dockerhub_image_path
```

## Usage

### Building docker images

1. Write a Dockerfile.

A Dockerfile is what docker uses to build images. To write one, create a file named Dockerfile (first letter caps, no extensions). A basic Dockerfile looks like this:

```
# Comments
FROM ubuntu
MAINTAINER demousr@gmail.com

RUN apt-get update
RUN apt-get install –y nginx
ENTRYPOINT ["echo"]
CMD ["Image created"]
```

Dockerfile contain lines which all start with certain keywords. The keywords are non case sensitive, but are ALL_CAPS by convention.

FROM defines what image this new image will be based on. Only base images can be used as a base.
MAINTAINER is typically the email of the person maintaining the image. It is optional and can be any email.
RUN runs cmd commands on the image. Use multiple lines of this for multiple cmd commands.
CMD runs a cmd command run when the image is launched. Docker will only run the last CMD command.
ENTRYPOINT is similar to CMD but is not overridden when passing a cmd command during the docker run command. There is a difference between:

```
ENTRYPOINT ["command"]
ENTRYPOINT command
```

In the first instance, the optional_cmd_override attached to docker run will be attached to the end of the ENTRYPOINT command as it they were part of the list:

```
ENTRYPOINT ["command", "optional_cmd_override"]
```

In the second instance, ENTRYPOINT will not take into account optional_cmd_override

2. Build docker image.

After the Dockerfile is written, ensure that the docker daemon is running (in windows, docker desktop is running), then open cmd (or git bash) in the folder and enter:

```
<!-- Replace . with the Dockerfile directory if not in the same folder. -->
docker build -t image_name:tag_name .
```

Use -t to name the image. :tag_name is optional. Replace image_name with repo/image_name if you intent to push it to dockerhub later. If you did not tag your image, and wish to do so afterwards, use the following command to tag it:

```
docker tag image_id image_name:tag_name
```

3. Upload docker image

First we need to login to our dockerhub account. This is unnecessary if docker desktop is already logged in. Otherwise, basic recommended way to login requires you to store your password as a file and open it in the following way:

```
<!-- Use -p password instead of to login without a file. -->
<!-- windows -->
type password.txt | docker login -u username --password-stdin
<!-- linux -->
cat password.txt | docker login -u username --password-stdin
```

Once logged in, we can then push the image into the repo by entering:

```
docker push repo_name/image_name
```

### Running docker images

Docker is run primarily from the command line. The commands here are mainly for windows. For linux, add sudo in front of every command.

1. Downloading docker images

Docker images can be found at dockerhub using the search bar. Selecting an image reveals the docker pull command to pull the image. Images do not have to be pulled before running; if the image has not already been pulled, docker will automatically execute the pull command before running it. A docker pull command looks like this:

```
docker pull dockerhub_image_path
```

The dockerhub image path may just be the image name, or it can comprise repo_name/docker_image_name

Where the images are stored depends on the operating system. In windows, the location can be found in docker>settings>resources>disk_image_location. In linux, use the following command:

```
sudo docker info
```

From the results, look under "Docker Root Dir".

2. Running docker images.

To run a docker image, use the docker run command. In linux, add sudo to the front. By default, docker images will stop once all processes on it have finished running.

```
<!-- windows -->
docker run -p 80:80 dockerhub_image_path optional_cmd_override
```

When run, the image can be given a cmd command to run instead of the one specified in the Dockerfile.

Flags can be defined while using the docker run command, including:
-p defines the port mapping, in this case 80 (host) : 80 (container). To map multiple ports, -p can be called multiple times, such as -p 8080:8080 -p 50000:50000
--entrypoint new_command allows one to override ENTRYPOINT commands.
-d runs the container in detached mode (in the background). This means the command line will remain free to issue other commands, but also means you don't see the output of the container. Note that seeing the output of the container does not mean one can issue commands to it.
-e var=value passes an environmental variable from the host to the container. Important when running desktop applications on docker.
-rm means the container will be automatically removed when docker exits.
-it is actually two separate flags normally used together. It allows certain containers to stick around after its last foreground task is done. When using git bash on windows, enter winpty in front of the command like this:

```
winpty docker run -dit dockerhub_image_path
```

To access a running container (see 02_basic to build a indefinitely running test container) through bash, enter:

```
docker exec -it container_id_or_name /bin/bash
```

Other useful commands on a docker container are:

```
<!-- To see the output of a container in cmd. -->
docker attach container_id
<!-- To see all images currently running. -->
<!-- -a means all. -->
docker ps -a
<!-- Pause and unpause. -->
docker pause container_id
docker unpause container_id
<!-- To see cpu and memory usage on a container. -->
docker stats container_id
<!-- To see top processes. -->
docker top container_id
<!-- To stop a container. -->
docker stop container_id
<!-- To force stop a container. -->
docker kill container_id
<!-- To remove a container. -->
<!-- Use -f to remove a container even if it is still running. -->
docker rm container_id
```

3. Deleting docker images

To see all images, enter:

```
docker images
```

To remove one, enter:

```
docker rmi image_id
```

Other useful commands concerning docker images are:
```
<!-- Removes images not associated with a container.-->
<!-- Add -a to remove images associated with unused containers as well. -->
docker system prune
<!-- To see image details, notably exposed ports. -->
docker inspect image_id_OR_dockerhub_image_path
<!-- To see all commands entered into one. -->
docker history image_id_OR_dockerhub_image_path

```

### Docker daemon

Probably used more often on linux, where you may want to start or stop the docker daemon using:

```
service docker start
service docker stop
```
