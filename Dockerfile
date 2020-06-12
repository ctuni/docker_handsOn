###########################################################
# Dockerfile to build STAR container images
# Based on Ubuntu
############################################################
#Build the image based on Ubuntu
FROM ubuntu:latest

#Maintainer and author
LABEL maintainer "Cris <c.tuni.dominguez@gmail.com>" \
      version "0.1" \
      description "Docker image to run STAR Genome aligner, https://hub.docker.com/repository/docker/ctuni/imageclasse"

#Install required packages in ubuntu for STAR
RUN apt-get update
RUN apt-get install --yes build-essential gcc-multilib apt-utils zlib1g-dev git

#Install STAR
WORKDIR /usr/local/
RUN git clone https://github.com/alexdobin/STAR.git
WORKDIR /usr/local/STAR/
RUN git checkout 2.6.1b
WORKDIR /usr/local/STAR/source
RUN make STAR
ENV PATH /usr/local/STAR/source:$PATH

RUN apt-get update -y && apt-get install -y \
    wget unzip bzip2 g++ make ncurses-dev python default-jdk default-jre libncurses5-dev \
    libbz2-dev liblzma-dev

# Clean up and set Workingdir at Home
RUN apt-get clean
RUN apt-get remove --yes --purge build-essential gcc-multilib apt-utils zlib1g-dev wget
WORKDIR /
