# golang-dep
[![Docker Build Status](https://img.shields.io/docker/build/eduardoagrj/golang-dep.svg)](https://hub.docker.com/r/eduardoagrj/golang-dep/builds/)

Dockerized [golang dep command-line tool](https://github.com/golang/dep) with options to use:

    Usage: dep <command>

    Commands:

    init     Initialize a new project with manifest and lock files
    status   Report the status of the project's dependencies
    ensure   Ensure a dependency is safely vendored in the project
    prune    Prune the vendor tree of unused packages
    version  Show the dep version information

## Requirements

- Docker version 17.05 or later.

## Getting started

`docker run eduardoagrj/golang-dep [dep cli arguments here]`

## Usage

Create a multi stage docker builds for creating tiny Go images.

```
    FROM eduardoagrj/golang-dep AS builder
    COPY Gopkg.* *.go /go/src/app/
    WORKDIR /go/src/app/
    RUN dep ensure --vendor-only \
        && CGO_ENABLED=0 GOOS=linux go build -a -v -installsuffix netgo -installsuffix cgo  -o goapp *.go

    FROM scratch
    WORKDIR /app
    COPY --from=builder /go/src/app/ /app/
    EXPOSE 8080
    CMD [ "./goapp"]
```

`docker build -t eduardoagrj/goapp .`

