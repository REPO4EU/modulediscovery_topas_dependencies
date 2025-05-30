FROM mambaorg/micromamba:debian12-slim

# use alpine such that ps is available
LABEL image.author.name="REPO4EU"
LABEL image.author.email="workflow@repo4.eu"
USER root
RUN apt-get update && \
    apt-get install -y git procps&& \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 
    
USER $MAMBA_USER
COPY --chown=$MAMBA_USER:$MAMBA_USER env.yml /tmp/env.yml
RUN micromamba install -y -n base -f /tmp/env.yml && \
    micromamba clean --all --yes 

ARG MAMBA_DOCKERFILE_ACTIVATE=1
RUN git clone https://bitbucket.org/sonnhammergroup/topas.git
ENV PATH="${PATH}:${MAMBA_ROOT_PREFIX}/bin"