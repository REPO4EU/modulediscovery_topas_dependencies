FROM mambaorg/micromamba:debian12-slim
LABEL image.author.name="REPO4EU"
LABEL image.author.email="workflow@repo4.eu"
USER root
RUN apt-get update && \
    apt-get install -y git procps&& \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 
COPY env.yml ./
RUN micromamba install -y -n base -f ./env.yml && \
    micromamba clean --all --yes
RUN  git clone https://bitbucket.org/sonnhammergroup/topas.git /topas
WORKDIR /topas 
ARG MAMBA_DOCKERFILE_ACTIVATE=1
ENV PATH="${PATH}:${MAMBA_ROOT_PREFIX}/bin"