# Docker container for MSc Bioinformatics Otter Grader Marking

## Instructions
The Dockerfile here contains the build script for a container which has installed Otter Grader for marking student submissions. It is built on the R 4.0.3 base image, which is itself a Debian based container.

Once built, the Docker container can be turned into a .tar file for Singularity consumption as:

```bash
# On local machine:
docker save otter-grader >> otter-grader.tar
sftp <username>@bluebear.bham.ac.uk <<< $'put otter-grader.tar'
# On BlueBEAR
singularity build otter-grader.sif docker-archive://otter-grader.tar
```

Alternatively, the container can be pushed to a Docker registry and then pulled down as normal via Singularity:
```bash
singularity pull docker://user/otter-grader
```

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

Packages can be added by adding them to requirements.r (for R) and requirements.txt (for Python). You may need to re-force building as not clear whether Docker will consider the latest layer stale if the requirements.txt has been updated but the Dockerfile has not.

