.PHONY: build

USER=pepperr

all: build upload

build:
	sudo docker build . -t otter-grader && \
	docker save otter-grader -o otter-grader.tar	
	singularity build otter-grader.sif docker-archive://otter-grader.tar
	rm -rf otter-grader.tar

upload:
	rsync -avH --progress otter-grader.sif -e ssh ${USER}@bluebear.bham.ac.uk:/rds/projects/c/cazierj-msc-bioinformatics-dl/otter-grader
