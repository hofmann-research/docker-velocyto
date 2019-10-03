FROM ubuntu:18.04

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.velocyto="0.17.17" \
      source.velocyto="https://github.com/velocyto-team/velocyto.py/releases/tag/0.17.17"

ENV VELOCYTO_VERSION 0.17.17

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN apt-get update \
    && apt-get install --yes build-essential python3 python3-pip

RUN apt-get install --yes wget zlib1g-dev libbz2-dev liblzma-dev

RUN pip3 install numpy scipy cython numba matplotlib scikit-learn h5py click
RUN pip3 install velocyto==${VELOCYTO_VERSION}

ENTRYPOINT ["velocyto"]
CMD ["--help"]
