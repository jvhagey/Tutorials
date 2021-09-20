---
title: Docker and Singularity
sidebar: mydoc_sidebar
permalink: mydoc_docker.html
folder: mydoc
---

{::options parse_block_html="true" /}

# Docker and Singularity

This page shows you how to build and run containers. For some container basics first check out the [containers page](https://xxh5.pages.biotech.cdc.gov/wdpb_bioinformaticstrainings/mydoc_containers.html).
 
## Docker Installation

The instructions for installing docker on windows is found in their [documentation](https://docs.docker.com/docker-for-windows/install/). Once installed you can just open your command prompt terminal and run docker through it. Alternatively, you can use a linux distro as described below. 

Once you download and install like a normal application on windows, update linux kernal as is described in this [documentation](https://docs.microsoft.com/en-us/windows/wsl/install-win10#step-4---download-the-linux-kernel-update-package) see step 4. Next you will need to update the kernal and then change the install version of WSL to WSL-2. This is detailed [here](https://www.configserverfirewall.com/windows-10/convert-wsl-1-linux-distribution-to-wsl-2/). 

We can change our Ubuntu terminal to WSL-2.

{% include warning.html content="**BEFORE YOU DO THIS!!!!** This has known issues [1](https://github.com/microsoft/WSL/issues/4275) and [2](https://github.com/microsoft/WSL/issues/6427) that if you convert to wsl-2 it will break commands that connect to the internet (wget, apt-get, ping, conda etc...). See the [installing wsl](https://git.biotech.cdc.gov/xxh5/wdpb_bioinformaticstrainings/-/blob/master/pages/mydoc/mydoc_wsl.md) page for more details." markdown="span" %}

You can switch back and forth between WSL-1 and WSL-2 more details [here](https://www.sitepoint.com/wsl2/) and microsofts [documentation](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

```
wsl --set-version Ubuntu-20.04 2
```

Check the version is correct now.

```
wsl --list -v
```

Cool, now we have docker installed on our windows machine and have Ubuntu installed. Now we will need to go in to the docker GUI and [configure](https://docs.docker.com/docker-for-windows/wsl/), which WSL 2 distros you want to access Docker from (in my case Ubuntu). 

If you haven't installed a linux distribution for wsl yet then check out the [wsl install tab](https://xxh5.pages.biotech.cdc.gov/wdpb_bioinformaticstrainings/mydoc_wsl.html). 

## Links to Tutorials

There are tutorials out there already so I'm not going to reinvent the wheel here. There is one from [docker](https://docs.docker.com/get-started) and another from [docker-curriculum](https://docker-curriculum.com) that show examples of how to use docker containers. Singularity also offers a nice [tutorial](https://sylabs.io/guides/3.3/user-guide) and there is an introductory workshop on Singularity from the [NIH](https://singularity-tutorial.github.io/). If you are familiar with [Software Carpentry](https://software-carpentry.org/) they also offer a [quick guide](https://pawseysc.github.io/singularity-containers/12-singularity-intro/index.html#:~:text=When%20pulling%20images%2C%20Singularity%20stores,singularity%2Fcache%20) to Singularity. This [Singularity tutorial](https://singularity.lbl.gov/archive/docs/v2-3/user-guide) is good, but its a little older. Between all of this documentation you can pretty much find the answer you need. 

StaPH-B has had monthly calls to give video demos of both [Docker](https://www.youtube.com/watch?v=V9AKvZZCWLc) and [Singularity](https://www.youtube.com/watch?v=juPLTMnFrcI&t=119s). These are hour long videos so in a pinch you can get a shortened version [here](https://youtu.be/rhA88i8PM18?t=68). 

**StaPH-B has also put together [resources](https://staph-b.github.io/docker-builds/run_containers/) for how to run docker containers and I highly suggest reading through this documentation.**

## Short Tutorial

You can pull a docker image that is hosted on dockerhub by using the `docker pull` command and the path to the image. For example, `docker pull staphb/fastqc:0.11.8`. This gives the following output:

```
0.11.8: Pulling from staphb/fastqc
e80174c8b43b: Pull complete
d1072db285cc: Pull complete
858453671e67: Pull complete
3d07b1124f98: Pull complete
3da427bee862: Pull complete
83986ed6345a: Pull complete
2c73083165ce: Pull complete
Digest: sha256:ac887ee1ed18062237dc605e4dc0943a89c430ab25badd656f2c24f6c9b1c96f
Status: Downloaded newer image for staphb/fastqc:0.11.8
docker.io/staphb/fastqc:0.11.8
```

This means that the docker image has been installed and no further installation is necessary. Pretty cool. 

You can inspect what docker images are avaliable on your computer currently with `docker image ls`. 

```
REPOSITORY               TAG       IMAGE ID       CREATED         SIZE
staphb/fastqc            0.11.8    28f81db693db   17 months ago   474MB
```

We can inspect our image to get its metadata:

```
docker image inspect 28f81db693db > fastqc_inspect.json
```

If we want to run something inside the container:

```
docker run -it --name fastqc_test staphb/fastqc:0.11.8
fastqc --help
```

And this should give us the output of `fastqc --help` like we would normally expect. The `-it` will tell docker we want to interactive with the container. Type `exit` to get out of the container. However, it will still be present on the computer and we can see all containers if you run `docker container ls --all`. 

{% include note.html content="`docker ps` is the same as `docker ls` or `docker list` (why the redundancy? I don't know)." %}

```
CONTAINER ID        IMAGE                    COMMAND                  CREATED             STATUS                      PORTS                NAMES
2b244637a3e6        staphb/fastqc:0.11.8     "/bin/bash"              8 minutes ago       Exited (0) 3 minutes ago                         fastqc_test
```

To get back "into" the container you will first start it then "attach" it like this:

```
docker start fastqc_test
docker attach fastqc_test
```

There isn't much we can do in this container right now though because we are "inside" our container and isolated from the files we actually want to run. Bummer. 

So what we need to do is "mount" the files of interest into the container using the `-v` command. Assuming you are currently in the directory you want to mount run the following:

```
docker run -it --rm=True -v $PWD:/data -u $(id -u):$(id -g) --name fastqc_with_folder staphb/fastqc:0.11.8
```

Now you can run `ls` in your container can you will find your files there! 

We also added a couple new arguments which were explained on the [StaPH-B webpage](https://staph-b.github.io/docker-builds/run_containers/):

```
# explanation
  --rm=True
     By default, when a Docker container is run without this flag, the Docker container is created,
     the container runs, and then exits, but is not deleted. In other words, Docker containers
     are NOT ephemeral by default. A local copy of the container is kept and takes up unnecessary
     storage space. It is a good idea to always use this flag so that the container is removed after
     running it, unless for some reason you need the container after the specified program has been run.

  -v $PWD:/data
     The -v flag mounts a volume between your local machine and the Docker container. This specific
     command mounts the present working directory to the /data directory within the Docker container,
     which makes the files on your local machine accessible to the container. You can change these
     paths to meet the needs of your system, however it is a good idea to have a working directory
     in each of the containers, and thus each container contains the /data directory for such purpose.

  -u $(id -u):$(id -g)
     By default, when Docker containers are run, they are run as the root user. This can be problematic
     because any files created from within the container will have root permissions/ownership and
     the local user will not be able to do much with them. The -u flag sets the container's user and group
     based on the user and group from the local machine, resulting in the correct file ownership.
```

To remove a container first we will have a look at what is running: 

```
CONTAINER ID        IMAGE                    COMMAND                  CREATED             STATUS                      PORTS                NAMES
2b244637a3e6        staphb/fastqc:0.11.8     "/bin/bash"              8 minutes ago       Exited (0) 3 minutes ago                         fastqc_test
```

To stop it `docker stop 2b244637a3e6` with then remove it `docker rm 2b244637a3e6`.

{% include note.html content="Instead of using the container ID in these commands you could have used the `fastqc_test`." markdown="span" %}

## Pulling and Building Images with Docker and Singularity

You can use the `pull` and `build` commands to download pre-built images from an external resource like the [Container Library](https://cloud.sylabs.io/library) or [Docker Hub](https://hub.docker.com/).

For example you can pull StaPH-B's image of fastqc like this:

```
# With docker
docker pull staphb/fastqc

# With Singularity
singularity pull docker://staphb/fastqc
```

By default this will pull the lastest image, which isn't ideal for reproducibility so it's best practice to actually put in the version of the software image you want pulled. 

```
# With docker
docker pull staphb/fastqc:0.11.9

# With Singularity
singularity pull docker://staphb/fastqc:0.11.9
```

## Useful Docker Commands

[Documentation for all Docker commands](https://docs.docker.com/engine/reference/commandline/docker/).

Useful commands for Docker: 

- List your images: `docker image ls`  
- Delete a specific image: `docker image rm [image name]`  
- Delete all existing images: `docker image rm $(docker images -a -q)`  
- List all existing containers (running and not running): `docker ps -a`
- Stop a specific container: `docker stop [container name]`  
- Stop all running containers: `docker stop $(docker ps -a -q)`  
- Delete a specific container (only if stopped): `docker rm [container name]`  
- Delete all containers (only if stopped): `docker rm $(docker ps -a -q)`  
- Display logs of a container: `docker logs [container name]`  

## Running Singularity/Docker on HPC

Here we will look at an example of running bwa and samtools to align reads to a reference and create a bam file. Without containers you would normally do something like this:

```
module load bwa samtools
bwa mem reference.fasta sample.fastq | samtools view -b output.bam
```

Running the same line of code with a Docker container using Singularity (this assumes the container is at quay.io):

```
singularity exec docker://quay.io/biocontainers/bwa:0.7.17--p15.22.0_2 bwa mem
```

The url `quay.io/biocontainers/bwa:0.7.17--p15.22.0_2` is an link to an image of bwa stored on `quay.io`. Singularity pulls down the docker container builds it locally and executes it as a Singularity containter.

Lets add a few more arguments to this command:

```
singularity -s exec -B $(pwd)/data/reference:/reference docker://quay.io/biocontainers/bwa:0.7.17--p15.22.0_2 bwa index /reference/reference.fasta 
```

The `-s` makes it more silent so its not as verbose in its output. `-B` is a bind mount which gets the reference from the host machine (located at `$(pwd)/data/reference`) to a place inside the container in this case it places it at `/reference`.
 
Running with Docker on HPC with Singularity:

Just `qsub` the lines like you normally would when submitting a job to the cluster.  

## How to Build and Run Local Singularity Image

### Basics

I need to add more here........

`singularity exec`
`singularity build`

An alternative to exec is `shell`.
`singularity shell`


### Example

Perviously, we needed access to the quay.io repository and download the image. If you don't have access to do that then you can build a local image and save it.  

To build an image:

```
singularity build ./images/bwa-0.7.17.sif docker://quay.io/biocontainers/bwa:0.7.17--p15.22.0_2
singularity build ./images/samtools-1.9.sif docker://quay.io/biocontainers/samtools:1.9--h91753b0_8
```

Now you can run commands using these images similar to how we did before:

```
singularity -s exec -B $(pwd)/data:/data ./images/bwa-0.7.17.sif bwa mem /data/reference/reference.fasta /data/sample/sample.fastq \
singularity -s exec ./images/samtools-1.9.sif samtools view -b > ./output-local.bam
```

## How to Build and Run Local Docker Image

Write a docker file

```
cd Dockerfile
docker build --tag staphb/ivar:1.3.1_Titan .
```


## Docker vs Singularity Commands

| Task | Docker | Singularity |
| ---- | ------ | ---------- |
| Pull image from dockerhub | `docker pull staphb/fastqc` | `singularity pull docker://staphb/fastqc` |
| Execute command | `docker run staphb/fastqc fastqc` | `singularity exec fastqc_latest.sif fastqc` |
| Get a shell inside a container |  `docker run -it staphb/fastqc` | `singularity shell fastqc_latest.sif` |

*Table adapted from: Jake Garfin's StaPH-B seminar October 2019. Full video on [Youtube](https://www.youtube.com/watch?v=juPLTMnFrcI).*

### Differences in Build Commands

{% include image.html file="DvsC1.PNG" url="https://www.youtube.com/watch?v=juPLTMnFrcI" alt="cromwell_layout" caption="Slide from talk on Singularity from Jake Garfin during the monthly StaPH-B call October 2019. Full video on [Youtube](https://www.youtube.com/watch?v=juPLTMnFrcI)." max-width="600" %}

{% include image.html file="DvsC2.PNG" url="https://www.youtube.com/watch?v=juPLTMnFrcI" alt="cromwell_layout" caption="Slide from talk on Singularity from Jake Garfin during the monthly StaPH-B call October 2019. Full video on [Youtube](https://www.youtube.com/watch?v=juPLTMnFrcI)." max-width="600" %}


