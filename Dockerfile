FROM ubuntu:14.04
MAINTAINER Chris Laskey <contact@chrislaskey.com>
# Based on Dockerfile by Zohaib Rauf <zabirauf@gmail.com>

ENV PHOENIX_VERSION "0.14.0"

RUN locale-gen en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get -y install wget curl git make
RUN echo "deb http://packages.erlang-solutions.com/ubuntu precise contrib" >> /etc/apt/sources.list

RUN mkdir /downloads
WORKDIR /downloads

# Erlang
RUN wget http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc
RUN apt-key add erlang_solutions.asc
RUN apt-get update && apt-get -y install erlang

# Elixir
RUN mkdir /vendor
WORKDIR /vendor
RUN git clone https://github.com/elixir-lang/elixir.git

WORKDIR elixir
RUN git checkout v1.0.5 && make clean test
ENV PATH $PATH:/vendor/elixir/bin

# NodeJS
RUN apt-get install -y node npm

# Phoenix
RUN mkdir /phoenix
WORKDIR /phoenix
RUN ./phoenix-init.sh
WORKDIR /phoenix/app

CMD ["mix phoenix.server"]
