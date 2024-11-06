# Dev Containers 101

This folder contains the configuration files to create a [**Dev Container**](https://code.visualstudio.com/docs/remote/containers) for this project.

## Prerequisites

To use this Dev Container, you need to have the following tools installed on your machine:

- [Docker](https://www.docker.com/products/docker-desktop)
- [Visual Studio Code](https://code.visualstudio.com/download)
- [Visual Studio Code Remote - Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Visual Studio Code Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## Quickstart

1. Open this project in Visual Studio Code.
2. Click on the popup window where it says "Open a Remote Window", or type `Ctrl+Shift+P` (`Cmd+Shift+P` on Mac) and choose `Dev Containers: Reopen in Container`.

Visual Studio Code will then build the Docker image and start a new container with all the tools and dependencies required to work on this project.


## What's Included

The Dev Container is based on the official [Python 3](https://hub.docker.com/_/python) Docker image and includes the following tools:

- [Python 3](https://www.python.org/)
- [pip](https://pypi.org/project/pip/)
- [git](https://git-scm.com/)
- [Conda](https://anaconda.org/anaconda/conda)
- [Nvidia CUDA](https://docs.nvidia.com/cuda/doc/index.html)

### The files

- `.devcontainer/devcontainer.json`: Configures the Dev Container, including the Docker image, environment variables, and which folders to mount.
- `.devcontainer/Dockerfile`: The Dockerfile used to build the image.
- `.devcontainer/install-packages.sh`: A script to install additional tools and dependencies.
- `.devcontainer/requirements.base.txt`: A list of Python packages to install via `pip`. This is installed early in the container build; users should generally edit

### The environment

The Dev Container is configured to run as a non-root user with the same username and group ID as your local user. This ensures that any files created in the Dev Container will have the correct permissions when you access them from your host machine.

## Examples

To get started, open the file [`notebooks/example.ipynb`](notebooks/example.ipynb) in Visual Studio Code and run it (install Jupyter extensions if asked).

## Adding Packages

### Python Packages

To make sure that the packages are available if the container gets rebuilt, add any Python packages to [`requirements.txt`](requirements.txt). You can then install the requirements via:

```bash
pip install -r requirements.txt
```

### Other Tools

If you need other tools available, edit the `.devcontainer/install-packages.sh` file. After editing the file, test that it runs:

```bash
# Make edits to .devcontainer/install-packages.sh, then run
.devcontainer/install-packages.sh
# Check that your tool works as expected, cleans up any excess file downloads, etc
```

Once the script runs successfully, you can rebuild the container by pressing `Cmd+Shift+P` (`Ctrl+Shift+P` on Windows/Linux) and selecting `Dev Containers: Rebuild Container`.

## Where Are My Files?

A Dev Container is like a "computer within a computer," which can be a bit confusing. The main advantage of this approach is that your code is isolated and easier to reproduce in the future because you keep track of your dependencies explicitly, and your changes are isolated from the server running the container.

The downside of this isolation is that your files may be harder to find and share. To make things easier, the Dev Container shares a few

## Installing new tools

To update your dev container and persist the changes, edit the files 