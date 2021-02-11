---
title: Anaconda Setup
sidebar: mydoc_sidebar
permalink: mydoc_Setup.html
folder: mydoc
---

## Conda set up

Anaconda has "channels" that are community maintained packages. 

[conda-forge:](https://conda-forge.org/)
- common dependencies (gcc, g++, etc)
- languages (python)  
- data science type packages (numpy, scipy, machine learning packages)

[bioconda:](https://bioconda.github.io/)
- Bioinformatics packages 
- Depends on conda-forge dependencies

```
conda config --add channels bioconda
conda config --add channels conda-forge
```

## Creating Conda Environment

Once we have Anaconda installed we can create an environment to install Snakemake into.

You can do this in one line:

```
conda create --name smake snakemake
```

Or two:

```
conda create --name smake
conda install --name smake snakemake
```

Or you can activate the environment and install inside it:

```
conda create --name smake
source activate smake
conda install snakemake
```

## Creating Conda Environment

If you want a particular version you can search to see what is available:

```
conda search snakemake
```

Then install that version:

```
conda create --name smake snakemake==5.32.0
```

## Activating the Environment

When you want to run snakemake you can activate your environment with:

```
source activate smake
```

When you are done using the environment use the following to exit the environment.
```
conda deactivate
``` 

If you forgot what your named your environment(s).

```
conda env list
```

If you messed up just delete and start over.

```
conda remove --name smake --all
```

Or 

```
conda env remove --name name
```
