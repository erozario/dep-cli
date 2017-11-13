FROM golang:alpine
LABEL author="eduardoagrj@gmail.com"

RUN apk add -q --update \
    && apk add -q git \
    && rm -rf /var/cache/apk/* \
    && go get github.com/golang/dep/cmd/dep 

ENTRYPOINT ["/go/bin/dep" ]
CMD ["--help"]