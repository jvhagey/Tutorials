# Example Files for Running wdl

1. Running wdl locally

`java -jar cromwell-59.jar run Tutorial_Local.wdl --inputs Tutorial.inputs.json`

2. Running wdl on a SGE HPC

`java -jar -Dconfig.file=SGE.conf cromwell-59.jar run Tutorial_SGE.wdl --inputs Tutorial.inputs.json`

3. Running wdl with Docker Containers

`java -jar cromwell-59.jar run Tutorial_Container_Docker.wdl --inputs Tutorial.inputs.json`

4. Running wdl with Singularity Containers

`java -jar -Dconfig.file=Singularity.conf cromwell-59.jar run Tutorial_Container_Sing.wdl --inputs Tutorial.inputs.json`

5. Running wdl on SGE HPC with Singularity Containers

`java -jar -Dconfig.file=Singularity_SGE.conf cromwell-59.jar run Tutorial_Container_Sing_SGE.wdl --inputs Tutorial.inputs.json`


If you are using SLURM instead of SGE there are similar examples of config files found [here](https://cromwell.readthedocs.io/en/stable/tutorials/Containers/#configuring-cromwell-for-singularity). Other backend configs are found [here](https://github.com/broadinstitute/cromwell/tree/develop/cromwell.example.backends). 
