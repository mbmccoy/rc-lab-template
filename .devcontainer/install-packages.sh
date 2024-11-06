#!/bin/bash
set -ex

# If you edit this file, you'll need to run 
#
#    .devcontainer/install-packages.sh
#
# to install the packages. You can also consider rebuilding 
# the dev container by running the command: 
# 
#   `Remote-Containers: Rebuild and Reopen in Container`
# 
# from the command palette (F1 or Ctrl+Shift+P). Note that this will
# stop running processes like Jupyter notebooks.
#
# Rebuilding the dev container ensures that your changes are
# reproducible and that the dev container is up-to-date.

echo "Running .devcontainer/setup.sh to install additional packages..."
# Example: apt-get update && apt-get install --no-install-recommends -y vim

# Install Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh

export PATH="/opt/conda/bin:${PATH}"
conda init bash

echo "Done."