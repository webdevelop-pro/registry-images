#!/bin/bash
docker build -t cr.webdevelop.us/webdevelop-pro/concourse-dind:latest .
docker push cr.webdevelop.us/webdevelop-pro/concourse-dind:latest
