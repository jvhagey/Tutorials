---
title: Containers
sidebar: mydoc_sidebar
permalink: mydoc_containers.html
folder: mydoc
---

# Containers

This page gives background on what containers are and why we use them.

## What are Containers?

**Containers**:
- Includes all dependencies (frameworks, libraries, etc.) required to run an application in an efficient and bug-free.
    - They lack external dependencies.
- Lightweight (occupies less free memory space) makes them easy/quick to move "between" computers.
- Application runs in isolation.

**Benefits**: 
- *Portable*: This allows applications to work efficiently in different computer environments (portable).
- *Reproducible*: Ensures scientific results are consistent
- *Shareable*: Standard mechanism for deploying complex applications

## Types of Containers

The most common types of container are [Docker](https://www.docker.com/) and [Singlularity](https://sylabs.io/singularity/), but more are coming out including [Shifter](https://www.nersc.gov/research-and-development/user-defined-images/), [CharlieCloud](https://hpc.github.io/charliecloud/) and [Podman](https://podman.io).

## What are Docker Containers?

Docker is an open-source platform that helps a user to package an application and its dependencies into a Docker Container for the development and deployment of software. 

{% include image.html file="docker.PNG" url="" alt="docker" caption="" max-width="600" %}

## What is Singularity?

Singularity, was built in 2015 at Lawrence Berkeley National Labs. It is free and open source. Singularity does not rely on the docker ecosystem to build its containers, while Shifter and CharlieCloud do. 

**Singularity will work with StaPH-B's docker images!!**
 
The paper for Singularity is [here](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0177459).

## Singularity vs Docker

| Features | Docker | Singularity |
| -------- | ------ | ------------ | 
| Capable of running Docker containers | X | X |
| Zero configuration in SCBS environment |  | X |
| Needs elevated privileges to run | X |  | 

Docker needs root access to run in SCBS environment - this leads to security issues. 

In summary Singlularity is:

- More Secure
- No layers -- Singularity images are stored as read-only .sif files. This makes them easy to share
- Makes different assumptions
    - user inside container == user outside the container
        - Docker assumes (unless you tell it otherwise) you want to be the root user and if you generate files like this inside the container they will be "owned" by the root and you won't have permissions to modify them. 
   - Auto-mounts home dir inside container (when you use `shell`) -- allows you to use the same paths both inside and outside the container.
        - You can add the flag(s) `--no-home` and -B `$PWD:/data`if you don't want to mount the home dir and want to do something else.
        - With docker we typically mount what we want in `/data`
- More likely to be supported on a HPC systems -- AKA you can't have docker on Aspen, but you can have Singularity

## Learn More About Containers

Scicomp gives a ~45min [Container Seminar](https://info.biotech.cdc.gov/info/training-and-webinar-recordings/), which some of this material and images are pulled from. 

{% include image.html file="comparing_containers.PNG" url="" alt="docker" caption="Adapted from Kurtzer, G. M., Sochat, V., & Bauer, M. W. (2017). Singularity: Scientific containers for mobility of compute. PLoS ONE, 12(5), 1–20. https://doi.org/10.1371/journal.pone.0177459. Table found in John Pham's Seminar on Containers for OAMD." max-width="600" %}


{% include note.html content="Some of these things might be out of date as these technologies are under active development." markdown="span" %}

