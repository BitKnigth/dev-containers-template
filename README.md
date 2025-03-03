# dev-containers-template

### Description

This script will automate the creation of **distrobox** dev containers based on **podman**, allowing to copy some host configs from $HOME, also allowing to input wich configs to import (directly on the initialize-distrobox.sh for now).

The container is created with a separated $HOME dir for complete isolation of enviroments, thus the need to manually copy the configs.

\*\*Obs: The initialization try to install oh-my-zsh if not installed on the container-image, as automating the configuration of zsh based on my host config was one of the main problems that i intended to solve. Maybe if someone request or i get bored i increment more and more.

### Usage

How to use: 1. Choose one dockerfile template (or input your own) and generate a image of it using **podman**:
`podman build -t debian-python-base-dev -f debian-python-base-dev.dockerfile --no-cache 
    ` 2. Make initialize-distrobox.sh executable
`chmod x+ initialize-distrobox.sh`

    3. Run the script:
    `./initialize-distrobox.sh <container-name> <container-image>`

    4. Enter the dev container:
    `distrobox enter <container-name>`

### Todo

- [] Auto clone project repo if is a single repo
- [] Auto install dependencies if package.json ou pyproject.toml and poetry.lock is found
- [] More initialization customizations.
