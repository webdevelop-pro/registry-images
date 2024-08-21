FROM golang:1.23.0-alpine3.20@sha256:d0b31558e6b3e4cc59f6011d79905835108c919143ebecc58f35965bf79948f4

ARG GIT_COMMIT=unspecified
ARG BUILD_DATE=unspecified
ARG SERVICE_NAME=unspecified
ARG REPOSITORY=unspecified
ARG VERSION

LABEL GIT_COMMIT=$GIT_COMMIT
LABEL BUILD_DATE=$BUILD_DATE
LABEL SERVICE_NAME=$SERVICE_NAME
LABEL REPOSITORY=$REPOSITORY

ENV GOPATH=/usr/local/go
ENV VERSION=${VERSION:-unknown}

RUN apk add --no-cache make gcc musl-dev linux-headers git gettext ca-certificates

ADD . /app

WORKDIR /app

# Install swagger library
RUN go install github.com/go-swagger/go-swagger/cmd/swagger@latest
RUN ./build-deploy.sh download
RUN ln -s /usr/local/go/bin/go /usr/local/bin/go

COPY etc ./etc /app/etc/
CMD ["/bin/sh"]
