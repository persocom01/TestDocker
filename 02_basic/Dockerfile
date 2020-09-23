# Explains all the basics of a Dockerfile.
# Search for image on dockerhub, and use the tags tab to search for specific
# versions.
FROM ubuntu:18.04

# ARG are variables only available during build.
# This one prevents prompts from appearing while installing apache2.
ARG DEBIAN_FRONTEND=noninteractive
# ENV variables are available when the image is run.
# Enter echo $var1 in a bash shell to return the variable.
# Both ARG and ENV leave traces and are not recommended for private information.
ENV var1=1024
# Variables defined through run commands do not persist through each RUN step
# unless saved to a file and loading said file before using the variable again.
RUN export var2=disappearing_variable

# ADD and COPY do the same thing, but ADD automatically unzips certain file
# types including .tar.gz into a directory of the same name as the file.
# To copy to the current working directory use . as the path.
ADD run_command.zip /add_dir
COPY run_command.txt /copy_dir

# Because every RUN command works on a new container, in order change the
# directory in which RUN is called, WORKDIR is used. Alternatively:
# RUN cd /copy_dir && command
# WORKDIR /absolute_path or WORKDIR relative_path are both acceptable.
WORKDIR /copy_dir

# Necessary if you want to install packages.
# apt and apt-get are different utilities that roughly do the same thing.
# apt is recommended for users but apt-get is recommended for scripts.
RUN apt-get update
RUN apt-get install unzip
# Use -y to automatically answer yes to y/n questions.
RUN apt-get -y remove unzip

# This line allows the container to continue existing.
ENTRYPOINT ["tail", "-f", "/dev/null"]
