# pulling image of base-notebook
FROM jupyter/base-notebook

# author
LABEL Ravi Prakash <raviprakash.cf>

# going root for installation
USER root

## updating
RUN apt-get update

## installing wget, zip, and unzip 
RUN apt-get install -y wget zip unzip build-essential \
  && apt-get install -y python3 python3-pip \
  && rm -rf /var/lib/apt/lists/*

## installing the modernCrypto library
RUN wget https://ravi-prakash1907.github.io/Modern-Cryptography/pkgs/modernCrypto_latest.zip \
  && unzip modernCrypto_latest.zip -d /home/jovyan \
  && rm modernCrypto_latest.zip \
  && rm -rf /home/jovyan/work

## importing local code
WORKDIR /home/jovyan
COPY ./src .

# changing user to "$NB_USER" to run the image with non-root user by default
USER $NB_UID

## start notebook 
# custom parameter to install jupyter lab for ease while running the container with the option -e
ENV JUPYTER_ENABLE_LAB=yes