---
title: Anaconda Installation
sidebar: mydoc_sidebar
permalink: mydoc_Installation.html
folder: mydoc
---

The easiest way to install Snakemake (and other bioinformatics software) is via *conda*, which you get through Anaconda or miniconda.


<div align="center"> 

![Anaconda_Conda](images/MinicondavsAnaconda.webp "Ana_Mini")  
**It is both a package and environment manager.**

</div>

```
wget https://repo.anaconda.com/archive/Anaconda3-5.3.1-Linux-x86_64.sh
bash Anaconda3-5.3.1-Linux-x86_64.sh
```

Or for miniconda run

```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```

Installing Anaconda:

[![asciicast](https://asciinema.org/a/388536.svg)](https://asciinema.org/a/388536)


### Why Conda?

<div align="center"> 

![Conda](images/conda_logo.svg "Conda Logo")  
**It is both a package and environment manager.**

</div>

Conda has the advantages:
- Language agnostic   
- “Easy” installation of software/environment by: 
    - One line installation  
    - Autoresolves dependencies  
- Tracks versions  
- Environment isolation:  
    - Install conflicting software into different environments  
    - Install different versions of software to different environments  


There is a handy [Cheat Sheet](https://docs.conda.io/projects/conda/en/latest/user-guide/cheatsheet.html) for conda commands. 

### Conda vs Containers


{% include image.html file="compare_containters.jpg" url="" alt="conda_container" caption="" max-width="600" %}

Conda:
- Is lighter weight than VM/Containers.  
- Aggregates all the dependencies on top of existing OS.  
- **Does NOT** isolate your environment from the underlying OS.  


|       | VM | Containers | Conda |  
|-------|--------|--------|---------|  
| **Drivers** | Included | System | System |  
| **OS** | Included | Included | System |  
| **Programs** | Included | Included | Included |  

{% include important.html content="I swiped this cool table from Jiangwei Yao, Ph.D. who gave a training through OAMD titled *Building your own personal computing environment using Conda*." markdown="span" %}

You can take the same training in [April](https://info.biotech.cdc.gov/info/events/building-your-own-personal-computing-environment-using-conda-seminar/).



