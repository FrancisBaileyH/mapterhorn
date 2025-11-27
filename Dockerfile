FROM ubuntu:24.04

RUN apt update
RUN apt install -y just gdal-bin libgdal-dev build-essential wget unzip default-jdk
RUN wget -O "awscliv2.zip" "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

COPY --from=ghcr.io/astral-sh/uv:0.9.13 /uv /uvx /bin/

COPY ./pipelines /pipelines
COPY ./source-catalog /source-catalog
COPY ./distribution /distribution

WORKDIR /pipelines

RUN uv sync

ENTRYPOINT ["just"]