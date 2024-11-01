#!/bin/bash

# Check if UID, GID, and USER are provided
if [[ -z "$UID" || -z "$GID" || -z "$USER" || -z "$JUPYTER_PORT" ]]; then
  echo -e "\e[31m[ERROR] UID, GID, and USER environment variables are not set.\e[0m"
  echo -e "\e[33mTo run this container properly, you need to pass your user, group IDs, and username.\e[0m"
  echo -e "\e[33mYou can do this in one of the following ways:\e[0m"
  echo -e "\e[32m1. Pass UID, GID, and USER when calling docker-compose, e.g.,\e[0m"
  echo -e "\e[32m   UID=\$(id -u) GID=\$(id -g) USER=\$(id -un) docker-compose up\e[0m"
  echo -e "\e[32m2. Run the following one-liner to add them to the .env file:\e[0m"
  echo -e "\e[32m   echo -e \"UID=\$(id -u)\\nGID=\$(id -g)\\nUSER=\$(id -un)\\\\JUPYTER_PORT=\$(( \$(id -u) + 10000 ))\" >> .env\e[0m"
  echo -e "\e[31mExiting now.\e[0m"
  exit 1
fi

# Set permissions for the workspace directory
USER_ID=${UID:-0}
GROUP_ID=${GID:-0}
USERNAME=${USER:-root}
chown -R $USER_ID:$GROUP_ID /workspace

# Set Jupyter runtime, config, and data directories to locations writable by the user
export JUPYTER_RUNTIME_DIR=/workspace/.jupyter/runtime
export JUPYTER_CONFIG_DIR=/workspace/.jupyter/config
export JUPYTER_DATA_DIR=/workspace/.jupyter/data
mkdir -p $JUPYTER_RUNTIME_DIR $JUPYTER_CONFIG_DIR $JUPYTER_DATA_DIR
chown -R $USER_ID:$GROUP_ID /workspace/.jupyter

# Create group if not exists
if ! getent group $GROUP_ID &>/dev/null; then
  groupadd -g $GROUP_ID $USERNAME
fi

# Create user if not exists
if ! id -u $USERNAME &>/dev/null; then
  useradd -u $USER_ID -g $GROUP_ID -o -m $USERNAME
fi

# Run the command as the specified user, preserving the environment
exec su - $USERNAME -c "env JUPYTER_RUNTIME_DIR=$JUPYTER_RUNTIME_DIR \
    JUPYTER_CONFIG_DIR=$JUPYTER_CONFIG_DIR \
    JUPYTER_DATA_DIR=$JUPYTER_DATA_DIR \
    PYTHONPATH=$PYTHONPATH \
    HF_HUB_CACHE=$HF_HUB_CACHE \
    $*"
