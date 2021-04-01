---
title: Cromwell
sidebar: mydoc_sidebar
permalink: mydoc_cromwell.html
folder: mydoc
---

# Installation for Running WDL

## Cromwell

{% include image.html file="jamie_the_cromwell_pig.png" url="https://github.com/broadinstitute/cromwell" alt="cromwell" caption="" max-width="600" %}

Similar to Snakemake the combination of cromwell and wdl are a workflow management system. Cromwell is a workflow execution engine that will can run WDL workflows locally, on an HPC or in the cloud using a number of backends (Google Cloud, AWS, Apache Spark etc.). 

{% include image.html file="cromwell.png" url="https://f1000research.com/slides/6-1381" alt="cromwell_layout" caption=" Modified from: Voss K, Van der Auwera G and Gentry J. Full-stack genomics pipelining with GATK4 + WDL + Cromwell [version 1; not peer reviewed]. F1000Research 2017, 6(ISCB Comm J):1381 (slides) (https://doi.org/10.7490/f1000research.1114634.1)" max-width="600" %}

The github for cromwell is found [here](https://github.com/broadinstitute/cromwell).

Both wdl and cromwell are utilized on [Terra](https://app.terra.bio/) which uses a Google Cloud backend to run your workflows. Those that aren't use to the command line might find this GUI easier to use if they have a .wdl workflow already written.

## Installation - Conda

Documentation for cromwell is found [here](https://cromwell.readthedocs.io/en/stable/tutorials/FiveMinuteIntro/).

You can install cromwell with [conda](https://anaconda.org/bioconda/cromwell) or install following instructions [here](https://cromwell.readthedocs.io/en/stable/tutorials/FiveMinuteIntro/).

To see the versions that are available in conda, run the following:

```
conda search cromwell
```

Create a new environment and install cromwell into it. 

```
conda create --name cromwell
source activate cromwell
conda install cromwell
```

You can now run a .wdl workflow with the following:

```
source activate cromwell
cromwell run myWorkflow.wdl
```

## WOMtool

In addition to cromwell, the Broad Institute has developed [WOMtools](https://cromwell.readthedocs.io/en/develop/WOMtool/) that has commands that are useful in working with your .wdl scripts.

You can also install this with [conda](https://anaconda.org/bioconda/womtool). I installed this in the same environment as my cromwell since I will most likely always be using them together.

```
source activate cromwell
conda install womtool
```

Once installed you can run a womtool command like this:

```
womtool validate myWorkflow.wdl
```

## WDL Tools

Lastly, there is a program [wdltools](https://anaconda.org/bioconda/wdltool) that can also be installed with conda. Again I installed this in the same environment as my cromwell all of the tools work together. This program can do some fun things like create a JSON file of inputs your workflow. Kinda neat! We will use it in the tutorial later. 

```
source activate cromwell
conda install wdltool
```

## Graphviz

[Graphviz](http://www.graphviz.org/documentation/) is a graph visualization program that we will use to turn a .dot file of a DAG into an image like a png. Like the other programs we will install this in the same [conda](https://anaconda.org/anaconda/graphviz) environment as cromwell. Note here we are using a different channel called "anaconda" so we will pass that in with the `-c` command.

```
source activate cromwell
conda install -c anaconda graphviz
```

## Installation for HPC Use

If you are running Cromwell locally then you can install it in an conda environment and run it with a short hand of 
Cromwell run `Tutorial.wdl`. 

Once we start running cromwell on an HPC we will need to pass a config file to cromwell so we can't use an use the conda environment then. You can download the latest release of cromwell and womtool from their [github](https://github.com/broadinstitute/cromwell/releases). 

You can download them with this code:
I tend to put programs in a bin folder so first navigate there and then download them with the following:

```
wget https://github.com/broadinstitute/cromwell/releases/download/59/cromwell-59.jar
wget https://github.com/broadinstitute/cromwell/releases/download/59/womtool-59.jar
```

We can now run cromwell with the following:

`java -Dconfig.file=your.conf -jar $PATH/bin/cromwell-59.jar run Tutorial.wdl`

## Comparisions to Snakemake

Cromwell/wdl are quite verbose and it can be hard to tell what is the error/output and what is just it's normal "I'm just doing my thing". I think this makes it less approachable/harder for those who aren't use to command line. I do think installing it with conda makes it a bit easier because you just have to run `cromwell run` rather than `java -jar cromwell-XY.jar run myWorkflow.wdl` if you install without conda. However, this doesn't work once you try to submit jobs to a cluster so that is a bummer. 
