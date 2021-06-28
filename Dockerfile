FROM r-base:4.0.3

RUN apt-get update && apt-get install -y --no-install-recommends build-essential \ 
                                                                 python3 \
                                                                 python3-pip \
                                                                 python3-setuptools \
                                                                 python3-dev

# installing python libraries
RUN pip3 install --upgrade pip
ADD requirements.txt .
RUN pip3 install -r requirements.txt

# installing r libraries
ADD requirements.r .
RUN Rscript requirements.r

WORKDIR /submissions

