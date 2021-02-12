---
title: Snakemake Basics
sidebar: mydoc_sidebar
permalink: mydoc_Basic.html
folder: mydoc
---

# Baby Snakefile

Snakemake documenation can be found at its [readthedocs](https://snakemake.readthedocs.io/en/stable/) website.

The basics of snakemake:

- This is a rule based workflow management system. 

# Running Snakemake

You can run snakemake by requesting a file you want that occurs in the workflow


```
snakemake xxxx.fastq
```

# Wildcards

# "Checkpoints"

There has been a time in which I want all my files to get to finish up to a certain rule before processing. I don't know if this is the best way to do it??? I could forsee errors if you call calling on specific file. 

# Dynamic/Checkpoints

Here is a [blog](http://ivory.idyll.org/blog/tag/python.html) on checkpoints. 

# Some Helpful Commands

To have snakemake go through a dry run of its workflow so you can make sure its doing what you want before you submit 100 jobs us the `--dryrun` flag. 

```
snakemake --dryrun 
```

To visualize your workflow you can generate a .png image with:

```
snakemake --dag | dot -Tpng > dag.png
```

# Troubleshooting (AKA mistakes I made)

-  Snakemake will get mad if you have directories in the output (with no wildcard in them) if there are wildcards in other output files.
If a rule’s inputs have wildcards then it expects all outputs to have a wildcard as well. Otherwise it duplicates it and it will make directories multiple times. 

Snakemake will give this error:

```
SyntaxError:
Not all output, log and benchmark files of rule xxx contain the same wildcards. This is crucial though, in order to avoid that two or more jobs write to the same file.
```

**Solution**: put directories under `params:` rather than `output`.
