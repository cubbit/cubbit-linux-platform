# cubbit-linux-platform

## Use yocto locally

### Prerequisites

```shell
sudo apt-get install repo diffstat texi2html texinfo subversion chrpath gettext libncurses5-dev
```

### Setup:

```shell
repo init -u git@github.com:cubbit/cubbit-linux-platform.git -b dunfell
repo sync
```

## Use yocto inside a container

### Prerequisites

Build the docker image.
`YOCTOROOT` must be a folder in your home directory, where you will let `repo`
download metadata sources and `bitbake` to create build outputs.
```shell
docker build -t yocto-build --build-arg USERNAME=$USER --build-arg YOCTOROOT=yocto_build .
```

Start the container.
This will mount your local home into the container.
```shell
docker run -ti --user $(id -u):$(id -g) -v ~:/home/$USER yocto-build /bin/bash
```

### Setup

From the container, download yocto metadata:
```shell
repo init -u git@github.com:cubbit/cubbit-linux-platform.git -b dunfell
repo sync
```

## Usage

If you are using yocto inside a container, every following command must be
executed inside the container.

Import the bitbake environment.
You may need to create the `build` directory if it does not exist.
```shell
MACHINE=cell-v1 source setup-environment build/
```

Edit `conf/local.conf` to add the variables you need.
You must provide at least
- `MENDER_ARTIFACT_NAME`
- `CUBBIT_ROOT_PASSWORD`

Then use `bitbake` to build the cell image:
```shell
bitbake cubbit-image-docker
```

If this is the first time you run a `bitbake` command, you may want to go make
lunch or have a few pints.
