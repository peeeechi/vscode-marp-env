FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

ARG UID=1000
ARG GID=1000
ARG USER_NAME=md
ARG GROUP_NAME=${USER_NAME}
ARG PASSWORD=${USER_NAME}

ENV UID=${UID}
ENV GID=${GID}
ENV USER_NAME=${USER_NAME}
ENV GROUP_NAME=${GROUP_NAME}

RUN apt-get update && apt-get -y install \
    gosu \
    sudo \
    wget \
    vim \
    gnupg \
    git \
    default-jdk \
    graphviz \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 日本語フォント対応
RUN apt-get update && apt-get install -y \
    fonts-ipafont \
    fonts-ipaexfont \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g ${GID} ${GROUP_NAME} \
    && useradd -u ${UID} -g ${GID} -s /bin/bash -m ${USER_NAME} \
    && echo "${USER_NAME}:${PASSWORD}" | chpasswd \
    && usermod -G sudo ${USER_NAME}

RUN wget 'https://downloads.sourceforge.net/project/plantuml/plantuml.jar?r=http%3A%2F%2Fplantuml.com%2Fstarting&ts=1538667739&use_mirror=jaist' -O /usr/local/bin/plantuml.jar \
    && chmod +x /usr/local/bin/plantuml.jar

USER ${USER_NAME}

WORKDIR /home/${USER_NAME}/workspace
