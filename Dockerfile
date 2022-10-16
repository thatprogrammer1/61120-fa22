FROM ubuntu:22.04
LABEL Description="Build environment"

ENV HOME /root

SHELL ["/bin/bash", "-c"]

RUN apt update && apt -y --no-install-recommends install \
    build-essential \
    git \
    clang \
    cmake \
    gdb \
    default-jre \
    ninja-build  \
    flex \
    bison \
