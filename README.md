# rc-lab-template
Templates for RC lab code

## Setup

1. Create a repository from this template following [these instructions](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template).
2. Checkout the folder.
3. Rename the folder `my_project` to a python package name, e.g., `my_project_new`.
4. Find and replace `my_project` with `my_project_new`.
5. Copy the `.env.template` file to `.env` and edit the contents with your values.

## Workflow

Start a docker container running jupyter with a one-liner:

```console
docker compose build \
    && docker compose up my_project_jupyter \
    && docker compose logs -f 
```

This starts the jupyter project in the background. If you need to restart, add `docker compose down`. For a quick rebuild and run, this is the command:

```
docker compose down \
    && docker compose build \
    && docker compose up my_project_jupyter \
    && docker compose logs -f 
```

