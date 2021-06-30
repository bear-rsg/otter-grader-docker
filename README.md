# Container recipes for MSc Bioinformatics Otter Grader Marking

This repository contains the setup needed for building a Singularity container for using the otter-grader software on a HPC cluster, with isolation from user files but without using Docker on the cluster. It provides Python 3.9 and R 4.0.3.

## Requirements

* Docker (tested with 20.10.7)
* Singularity (tested with 3.7.4)

## Instructions
The Dockerfile here contains the build script for a container which has installed Otter Grader for marking student submissions. It is built on the R 4.0.3 base image, which is itself a Debian based container.

To build:

```bash
# Build it locally only:
make build

# Upload it:
make upload

# Build and upload to BlueBEAR:
make
```

Note that some user input is required because various stages require sudo access and your credentials for BlueBEAR.

On BlueBEAR itself, run as:

```bash
# Must use this line to avoid risk to other data
# as otherwise, student submissions will have access
# to your home directory, and all RDS directories that
# you have access to.
export SINGULARITY_BIND=""

# Open a bash shell in the container:
# singularity shell otter-grader.sif
singularity shell --contain --bind $PWD:$HOME otter-grader.sif

# OR run the otter software directly (for batch jobs):
singularity run --contain --bind $PWD:$HOME otter-grader.sif otter
```

## Packages

Packages can be added by adding them to requirements.r (for R) and requirements.txt (for Python).

