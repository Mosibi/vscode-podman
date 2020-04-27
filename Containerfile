FROM codercom/code-server:3.1.1
LABEL maintainer="richard@mosibi.nl"

USER root

###
# APT
###
RUN apt-get -y update && \
    apt-get -y install \
      openjdk-11-jdk \
      gcc \
      python3 \
      python3-pip \
      pylint3 && \
    rm -rf /var/lib/apt/lists/*

###
# PIP
###
RUN pip3 install ansible==2.8.11

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
    code-server --install-extension vscjava.vscode-java-dependency

