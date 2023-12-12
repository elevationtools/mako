
# Common to both build stage and final image.
FROM ubuntu:22.04 AS base
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update
RUN apt-get -y install bash
WORKDIR /mako_repo
ENV REPO_ROOT=/mako_repo


# Build stage, run the (pseudo) compile.
FROM base AS build
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install make
ENV MAKO_ROOT=${REPO_ROOT}/lib
ENV PATH=${MAKO_ROOT}/bin:${PATH}
ARG FOO=default_in_dockerfile
ENV FOO=${FOO}
WORKDIR ${REPO_ROOT}
COPY ./ ./
RUN mako -C tests/container/app_code

# Output image, copy the results of the (pseudo) compile.
FROM base
WORKDIR ${REPO_ROOT}/tests/container/app_code
COPY --from=build ${REPO_ROOT}/tests/container/app_code/genfiles/output ./output

