FROM codercom/code-server:3.9.0
LABEL maintainer="richard@mosibi.nl"

USER root

###
# APT
###
RUN apt-get -y update && \
    apt-get -y install \
      openjdk-11-jdk \
      gcc \
      maven \
      python3 \
      python3-pip \
      pylint3 \
      apt-transport-https \
      gnupg2 \
      curl && \
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y kubectl

###
# PIP
###
RUN pip3 install ansible==2.9.18

###
# Extra binaries
###
RUN curl -s  https://get.helm.sh/helm-v3.5.2-linux-amd64.tar.gz --output /dev/stdout | tar xvzf -  && mv linux-amd64/helm /usr/local/bin/helm

###
# VSCODE EXTENSIONS
###
RUN code-server --install-extension ms-python.python && \
    code-server --install-extension vscoss.vscode-ansible && \
    code-server --install-extension yzhang.markdown-all-in-one && \
    code-server --install-extension ms-vscode.cpptools && \
    code-server --install-extension redhat.java && \
    code-server --install-extension vscjava.vscode-java-debug && \
    code-server --install-extension vscjava.vscode-java-test && \
    code-server --install-extension vscjava.vscode-maven && \
    code-server --install-extension vscjava.vscode-java-dependency && \
    code-server --install-extension ms-kubernetes-tools.vscode-kubernetes-tools

###
# Cleanup
###
RUN rm -rf /var/lib/apt/lists/* /root/.cache
