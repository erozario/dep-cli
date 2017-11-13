# golang-dep
[![Docker Build Status](https://img.shields.io/docker/build/eduardoagrj/golang-dep.svg)](https://hub.docker.com/r/eduardoagrj/golang-builder-dep/builds/)

Dockerized [golang dep command-line tool](https://github.com/golang/dep) with options to use:

    Usage: dep <command>

    Commands:

    init     Initialize a new project with manifest and lock files
    status   Report the status of the project's dependencies
    ensure   Ensure a dependency is safely vendored in the project
    prune    Prune the vendor tree of unused packages
    version  Show the dep version information

## Getting started

`docker run eduardoagrj/golang-dep [dep cli arguments here]`

## Usage

Multi stage Docker Builds for Creating Tiny Go Images

- Dockerfile

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

- Docker build

```
    [erozario@rivendel goApp]$ docker build -t eduardoagrj/goapp .
    Sending build context to Docker daemon  195.6kB
    Step 1/9 : FROM eduardoagrj/golang-dep AS builder
    ---> c2dae321e998
    Step 2/9 : COPY Gopkg.* *.go /go/src/goapp/
    ---> Using cache
    ---> b1d47847ccff
    Step 3/9 : WORKDIR /go/src/goapp/
    ---> Using cache
    ---> f88ccefeaa2e
    Step 4/9 : RUN dep ensure --vendor-only     && CGO_ENABLED=0 GOOS=linux go build -a -v -installsuffix netgo -installsuffix cgo  -o goapp *.go
    ---> Using cache
    ---> c0e32e0b1937
    Step 5/9 : FROM scratch
    ---> 
    Step 6/9 : WORKDIR /app
    ---> Using cache
    ---> ff2a15182588
    Step 7/9 : COPY --from=builder /go/src/goapp/ /app/
    ---> Using cache
    ---> d72432a4ce68
    Step 8/9 : EXPOSE 8080
    ---> Using cache
    ---> d16205f5f3a6
    Step 9/9 : CMD [ "./goapp"]
    ---> Using cache
    ---> 4f3d0c930870
    Successfully built 4f3d0c930870
    Successfully tagged eduardoagrj/goapp:latest
```
