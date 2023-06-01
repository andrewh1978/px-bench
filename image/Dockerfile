FROM ubuntu:22.04
RUN apt update
RUN apt install -y gettext-base curl
RUN curl -Lo /usr/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN chmod 755 /usr/bin/kubectl
