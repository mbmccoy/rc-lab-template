# rc-lab-template
Templates for RC lab code

## Setup

This repo is setup to use VSCode and the Dev Containers plugin. Please make sure you've installed both before continuing.

1. Create a repository from this template following [these instructions](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template#creating-a-repository-from-a-template).
2. Checkout the folder, and open it in VSCode.
    1. You'll see a popup asking whether you want to reopen in a Dev Container. Choose OK.
        - Alternatively, type Ctrl+Shift+P (or Cmd+Shift+P on a Mac) and choose Dev Containers: Reopen In Container.
    2. If this is the first time building, it may take several minutes to start up. In this case, it's a good idea to watch the logs to see the progress (click on the popup window).
3. Rename the folder `my_project` to a python package name, e.g., `my_project_new`.
4. Find and replace `my_project` with `my_project_new`.
5. Copy the `.env.template` file to `.env` and edit the contents with your values.

## Examples

To get started, open the file [`notebooks/example.ipynb`](notebooks/example.ipynb) in VSCode and run it (install jupyter extensions if asked). 

## Adding packages

### Python packages

To make sure that the packages are available if the container gets re-built, make sure to add any python packages to [`requirements.txt`](requirements.txt). Then you can install the requirements via

```console
pip install -r requirements.txt
```

### Other tools

Do you need other tools available? In this case, you'll want to edit `.devcontainer/install-packages.sh`. After editing the file, first test that it runs:

```console
# make edits to .devcontainer/install-packages.sh, then run
.devcontainer/install-packages.sh
# .... check that your tool works as expected, cleans up any 
# excess file downloads, etc
```
Now that it runs, you can rebuild the container with CMD+SHIFT+P -> `Dev Containers: Rebuild Container`. This will take some time (3-5 minutes), but will rebuild your container in a consistent a reproducible way.


## Where are my files?

A dev container is a "computer-in-a-computer", which can get a bit confusing. The main advantage of this approach to development is that your code is isolated and much easier to reproduce in the future because you keep track of your dependencies explicitly (see above), and your changes are isolated from the server that's running the container.

The downside of this isolation is, well, isolation---your files may be harder to find and share. To make things a bit easier, we've set up the dev container to share a few files.

| What is it?           | On the server   | Inside the container | Notes                     |
|-----------------------|-----------------|----------------------|---------------------------|
| This directory (code) | `/path/to/code` | `/workspace/code`    | Changes to code will be kept in sync with the host machine. Use git to store changes, etc.
| Home directory     | `$HOME` | Not available, except the code directory above. | This is a best-practice convention to help keep projects and data isolated, but see below.
| Shared data | `/mnt/raid/data` | `/shared-data` | This is a folder that any user and projet can read and write to. Since it's a shared data folder, care must be taken to ensure that you don't have name conflicts between projects.

For the details on this, see [`.devcontainer/devcontainer.json](.devcontainer/devcontainer.json).


## Best practices

### Where to put my data?

For project and user-specific data, we recommend storing the data in the `./data/` directory. By default, all files in there will be ignored by `git`, so you won't accidentally commit large files to the repo.

For data that needs to be shared between users or projects, we recommend creating `/shared-data/<project>` in the container, which corresponds to `/mnt/raid/data/<project>` on the server. 


### Tests

We strongly encourage you to write tests for your code. We've included an example file to get you started with python tests. The basic pattern is, for each python file `my_file.py`, create a `my_file_test.py`. Then you can run tests using the `pytest` framework with `pytest`:


```
$ pytest .
====================== test session starts ======================
platform linux -- Python 3.12.7, pytest-8.3.3, pluggy-1.5.0
rootdir: /workspaces/rc-lab-template
plugins: anyio-4.6.2.post1
collected 1 item                                                

my_project/example_test.py .                              [100%]

======================= 1 passed in 0.02s =======================
```
