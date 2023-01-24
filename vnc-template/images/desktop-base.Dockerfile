FROM codercom/enterprise-vnc:ubuntu

# We're running as USER coder

ENV SHELL=/bin/bash

COPY --chown=coder:coder jetbrains-idea-ce.desktop /home/coder/.local/share/applications/jetbrains-idea-ce.desktop

RUN echo "nameserver 10.0.1.1" | sudo tee -a /etc/resolve.confs

# Install IntelliJ
RUN mkdir /home/coder/software && \
    cd /home/coder/software && \
    curl https://download-cdn.jetbrains.com/idea/ideaIC-2022.3.1.tar.gz | tar xvz && \
    mv idea-IC-223.8214.52 idea && \
    sudo chown coder:coder -R /home/coder/

# Install java and some helpful utils
RUN sudo apt update && sudo apt install -y openjdk-17-jdk-headless iputils-ping

RUN sudo apt install nano