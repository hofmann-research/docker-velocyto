FROM ubuntu:18.04

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.velocyto="0.17.17" \
      version.samtools="1.9" \
      source.velocyto="https://github.com/velocyto-team/velocyto.py/releases/tag/0.17.17" \
      source.samtools="https://github.com/samtools/samtools/releases/tag/1.9"

ENV VELOCYTO_VERSION 0.17.17
ENV SAMTOOLS_VERSION 1.9

# required by click
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

# update package manager, build essentials, and install python 3
RUN apt-get update \
    && apt-get install --yes build-essential python3 python3-pip

# install dependency required by samtools
RUN apt-get install --yes wget libncurses5-dev zlib1g-dev libbz2-dev liblzma-dev

# install samtools (which is required by velocyto)
RUN cd /tmp \
    && wget https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2 \
    && tar xvjf samtools-${SAMTOOLS_VERSION}.tar.bz2 \
    && cd samtools-${SAMTOOLS_VERSION} \
    && ./configure --prefix=/usr/local \
    && make \
    && make install \
    && cd / && rm -rf /tmp/samtools-${SAMTOOLS_VERSION}

# install python packages required by velocyto
RUN pip3 install numpy scipy cython numba matplotlib scikit-learn h5py click

# install velocyto
RUN pip3 install velocyto==${VELOCYTO_VERSION}

ENTRYPOINT ["velocyto"]
CMD ["--help"]
