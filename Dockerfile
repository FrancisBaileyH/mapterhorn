FROM ubuntu:24.04

RUN apt update
RUN apt install -y just gdal-bin libgdal-dev build-essential wget

COPY --from=ghcr.io/astral-sh/uv:0.9.13 /uv /uvx /bin/

COPY ./pipelines /pipelines
COPY ./source-catalog /source-catalog
COPY ./distribution /distribution

WORKDIR /pipelines

RUN uv sync

ENTRYPOINT ["just"]