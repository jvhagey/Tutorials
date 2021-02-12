---
title: Snakemake Basics
sidebar: mydoc_sidebar
permalink: mydoc_Basics.html
folder: mydoc
---

# Files for Running Snakemake on Sun Grid Engine

The files `sge-submit.py`, `sge-status.py`, `cluster.yaml` (or `cluster.json`) and `config.yaml` should be added to the folder `~/.config/snakemake/Profile_Name`. The `config.json` file should be in the same folder as your Snakemake file and is used to add in commonly used paths to simplify the snakemake workflow. 

These can then be called with `time snakemake --profile Profile_Name -j 10 --scheduler greedy`

The options for running jobs on the cluster are read and overwritten in the following order:
1.  Default options in `QSUB_DEFAULTS` in `sge-submit.py`.   
2.  Default options (`__default__`) in the profile’s `cluster.yaml` or (`cluster.json`) file.  
3.  Resources and threads (`time, mem`) for the rule in the Snakemake file.  
4.  Rule specific options in the profile’s `cluster.yaml` or (`cluster.json`) file.  
5.  Default and rule specific options in the cluster config pass with --cluster-config (deprecated since Snakemake 5.10).  

The profile files can be found [here](https://github.com/drjbarker/snakemake-gridengine) these were [forked](https://github.com/Snakemake-Profiles/sge) to use cookiecutter.

Alternatively, (deprecated and more typing) you can run Snakemake on the cluster by creating a `cluster.json` or `cluster.yaml` file and passing each parameter set in that file to be parsed by Snakemake using the `--cluster` and `--cluster-config` flags.  

```
time snakemake -j 10 --cluster-config cluster.json --scheduler greedy --cluster-status $PATH/sge-status.py --cluster "qsub -terse -N {cluster.name} -l {cluster.mem} -o {cluster.outfile} -e {cluster.errfile} -q {cluster.nodes} -pe {cluster.cpus}"
```

The number of jobs that are submitted at a time can be set in the `config.yaml` file with `jobs: 100` or alternatively can be passed with `-j 100`. I like to use the `-j #` for trouble shooting and then will change the `jobs: ##` later when its all working. 

The `--cluster-status` flag its used by Snakemake to determine if a job has finished successfully or failed. For this it is necessary that the submit command provided to --cluster returns the cluster job id (`-terse` does this). Then, the status command will be invoked with the job id. Snakemake expects it to return 'success' if the job was successfull, 'failed' if the job failed and 'running' if the job still runs. 

I have kept running into the following error on Aspen (with a variety of different rules) so I would suggest addding `--scheduler greedy` to your snakemake lines as snakemake suggests. 

```
WorkflowError:
Failed to solve the job scheduling problem with pulp. Please report a bug and use --scheduler greedy as a workaround:
Pulp: Error while trying to execute, use msg=True for more detailscbc
```

# Known Errors

Sometimes sge-status.py does complain about a job id not being able to be found for example: `error: job id #######`. It's unclear why the sge-status.py script is giving this error, but it doesn't seem to keep snakemake from running correctly. So for now ignore it. 
