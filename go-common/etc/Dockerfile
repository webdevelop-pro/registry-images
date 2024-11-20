FROM cr.webdevelop.us/webdevelop-pro/go-common:latest-dev AS builder

ARG GIT_COMMIT
ARG BUILD_DATE
ARG SERVICE_NAME
ARG REPOSITORY

LABEL GIT_COMMIT=$GIT_COMMIT
LABEL BUILD_DATE=$BUILD_DATE
LABEL SERVICE_NAME=$SERVICE_NAME
LABEL REPOSITORY=$REPOSITORY

ENV GOPATH=/go
ENV VERSION=${VERSION:-unknown}

RUN apk add --no-cache make gcc musl-dev linux-headers git gettext

ADD . /app

WORKDIR /app

RUN ./make.sh build

FROM alpine:3.20

RUN apk add --no-cache ca-certificates curl

#does not work for the worker
#HEALTHCHECK --interval=10s --timeout=1s \
#  CMD curl -f http://localhost:8085/healthcheck || exit 1

WORKDIR /app
COPY --from=builder /app/http /app/http
COPY --from=builder /app/worker /app/worker

CMD ["/app/http"]
