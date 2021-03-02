# vscode-podman
Run Visual Studio Code in a browser as regular user with Podman

The people from coder.com created [code-server](https://github.com/cdr/code-server) which is VS Code running on a remote server, accessible through the browser. This
project uses the container they created and extends that with serveral extensions. The main purpose is to have a fully working development container that can be
used in an environment where internet connectivity is not available, also known as an **airgapped** environment.

## Build the container
```lang=shell
$ podman build -t code-server:3.9.0-$(id -un) .
```

## Run the container
```lang=shell
$ podman run -it -p 127.0.0.1:8080:8080 --rm -v "${HOME}/mycode:/home/coder/project:z"  -v "${HOME}/.config:/home/coder/.config:z" --name vscode localhost/code-server:3.9.0-$(id -un)
```

After starting the container, open the url http://localhost:8080 in your browser, the password is in ~/.config/code-server/config.yaml

## Why 'USER root' in the Containerfile?
Running the container as a regular user with a non-root user in the container, results in a permission denied on every action in your home directory. Please do not start the container as root user....
