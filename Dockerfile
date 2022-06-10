FROM ubuntu:20.04

LABEL MAINTAINER="Cubbit srl <connect@cubbit.io>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y gawk wget curl git-core diffstat unzip \
        texinfo gcc-multilib build-essential chrpath socat cpio python3 \
        python3-pip python3-pexpect xz-utils debianutils iputils-ping \
        python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm \
        python3-subunit mesa-common-dev texi2html texinfo subversion \
        gettext libncurses5-dev python locales tmux vim

RUN curl https://storage.googleapis.com/git-repo-downloads/repo -o /usr/bin/repo && chmod +x /usr/bin/repo

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8

ARG USERNAME=dev
ARG PGID=1000
ARG PUID=1000
ARG YOCTOROOT=yocto_build

RUN groupadd -g ${PGID} ${USERNAME} \
            && useradd -u ${PUID} -g ${USERNAME} -d /home/${USERNAME} ${USERNAME} \
            && mkdir /home/${USERNAME} \
            && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

USER ${USERNAME}
VOLUME /home/${USERNAME}
WORKDIR /home/${USERNAME}/${YOCTOROOT}
