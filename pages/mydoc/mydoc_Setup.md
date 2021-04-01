---
title: Anaconda Setup
sidebar: mydoc_sidebar
permalink: mydoc_Setup.html
folder: mydoc
---

# Using Conda Environments

## Conda Set Up

Anaconda has "channels" that are community maintained packages. You will need to add these "channels" to your setup so you Anaconda knows where to look for the packages you are trying to install.


<!-- <div align="center"> 

![Bioconda](images/bioconda.png "bioconda logo")  

</div>  -->

{% include image.html file="bioconda.png" url="https://bioconda.github.io/" alt="Bioconda" caption="" %}


[bioconda:](https://bioconda.github.io/)
- Bioinformatics packages 
- Depends on conda-forge dependencies


<!-- <div align="center"> 

![Conda-forge](images/conda-forge.png "Conda-forge logo")  

</div>  -->

{% include image.html file="conda-forge.png" url="https://conda-forge.org/" alt="Conda-forge" caption="" %}

[conda-forge:](https://conda-forge.org/)
- Common dependencies (gcc, g++, etc)
- Languages (python)  
- Data science type packages (numpy, scipy, machine learning packages)

```
conda config --add channels bioconda
conda config --add channels conda-forge
```

If you don't add channels then you can also pass the `-c` argument whenever installing, but who wants to remember that? As an example it would look like this.

```
conda create -c conda-forge -c bioconda -n smake snakemake
```

## Creating Conda Environment

Once we have Anaconda installed we can create an environment to install Snakemake into. You can name the environment whatever you want, but here I used the name smake. If you are going to install different versions of the software its probably best to add a the version to the name.

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

When you are done using the environment exit the environment with:

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
conda env remove --name smake
```

## Exporting Your Environment

Now that you have made your own custom environement you can export the details to a .yml file that can be used to install the exact same dependencies into an environment on a different computer. 

First export the details of the packages and their versions.

```
conda env export > environment.yml
```

Then on a new computer or instance recreate it. 

```
conda env create -f environment.yml
```

## Cheat Sheet

There is a handy [Cheat Sheet](https://docs.conda.io/projects/conda/en/latest/user-guide/cheatsheet.html) for conda commands. 


## Mamba

{% include image.html file="mamba_header.png" url="https://github.com/mamba-org/mamba" alt="Mamba-header" caption="" %}

If anyone has installed anything with conda they will come to realize the pain of the phrase `resolving environment`. More recently, there has been a reimplementation of the conda package manager in C++ called [Mamba](https://github.com/mamba-org/mamba). This was suppose to help speed up the process as the conda solver is a "bit slow" and sometimes has [issues](https://github.com/conda/conda/issues/9905) with selecting the latest package releases.  

You can install mamba with conda into the base environment! :smiley: :tada:

```
conda install mamba -n base -c conda-forge
```

You can then install snakemake like this:

```
mamba create --name smake snakemake
```
