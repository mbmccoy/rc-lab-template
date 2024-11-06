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


## Where are my files?

A dev container is a "computer-in-a-computer", which can get a bit confusing. The main advantage of this approach to development is that your code is isolated and much easier to reproduce in the future because you keep track of your dependencies explicitly (see above), and your changes are isolated from the server that's running the container.

The downside of this isolation is, well, isolation---your files may be harder to find and share. To make things a bit easier, we've set up the dev container to share a few files.

| What is it?           | On the server   | Inside the container | Notes                     |
|-----------------------|-----------------|----------------------|---------------------------|
| This directory (code) | `/path/to/code` | `/workspace/code`    | Changes to code will be kept in sync with the host machine. Use git to store changes, etc.
| Home directory     | `$HOME` | Not available, except the code directory above. | This is a best-practice convention to help keep projects and data isolated, but see below.
| Shared data | `/mnt/raid/data` | `/shared-data` | This is a folder that any user and projet can read and write to. Since it's a shared data folder, care must be taken to ensure that you don't have name conflicts between projects.

For the details on this, see [`.devcontainer/devcontainer.json](.devcontainer/devcontainer.json).

### Adding new volume mounts

If you need to mount additional directories into the dev container, you can edit the `mounts` section of the `.devcontainer/devcontainer.json` file. For example, to mount the `data` directory, you could add the following:

```json
"mounts": [
  "source=/path/to/data,target=/workspace/data,type=cached"
]
```