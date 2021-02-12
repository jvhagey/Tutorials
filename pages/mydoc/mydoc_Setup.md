---
title: Anaconda Setup
sidebar: mydoc_sidebar
permalink: mydoc_Setup.html
folder: mydoc
---

# Conda Set Up

Anaconda has "channels" that are community maintained packages. 

[conda-forge:](https://conda-forge.org/)
- Common dependencies (gcc, g++, etc)
- Languages (python)  
- Data science type packages (numpy, scipy, machine learning packages)

[bioconda:](https://bioconda.github.io/)
- Bioinformatics packages 
- Depends on conda-forge dependencies

```
conda config --add channels bioconda
conda config --add channels conda-forge
```

# Creating Conda Environment

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

# Creating Conda Environment

If you want a particular version you can search to see what is available:

```
conda search snakemake
```

Then install that version:

```
conda create --name smake snakemake==5.32.0
```

# Activating the Environment

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
conda env remove --name smakw
```

# Exporting Your Environment

Now that you have made your own custom environement you can export the details to a .yml file that can be used to install the exact same dependencies into an environment on a different computer. 

First export the details of the packages and their versions.

```
conda env export > environment.yml
```

Then on a new computer or instance recreate it. 

```
conda env create -f environment.yml
```

