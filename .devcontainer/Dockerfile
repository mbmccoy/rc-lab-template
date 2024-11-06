# Base image with Python
FROM mcr.microsoft.com/devcontainers/python:1-3.12-bullseye

ARG USERNAME=vscode

# Install CUDA and basic tools
RUN apt-get update && \
    apt-get install -y wget gnupg && \
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb && \
    dpkg -i cuda-keyring_1.0-1_all.deb && \
    apt-get update && \
    apt-get install -y \
    git curl unzip cuda-toolkit-12-5 && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/local/cuda/bin:${PATH}"

# Persist command history
# https://code.visualstudio.com/remote/advancedcontainers/persist-bash-history
RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
    && mkdir /commandhistory \
    && touch /commandhistory/.bash_history \
    && chown -R $USERNAME /commandhistory \
    && echo "$SNIPPET" >> "/home/$USERNAME/.bashrc"

# Install base Python requirements
COPY .devcontainer/requirements.base.txt /tmp/requirements.base.txt
RUN pip install -r /tmp/requirements.base.txt

# Run container setup script
COPY .devcontainer/install-packages.sh /tmp/install-packages.sh
RUN /tmp/install-packages.sh

# Install project-level Python requirements
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

# Update path for conda
ENV PATH="/opt/conda/bin:${PATH}"
