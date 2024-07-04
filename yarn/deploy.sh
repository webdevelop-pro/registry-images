docker build -t gcr.io/webdevelop-dev/yarn:`date +%d%m%Y` .
docker push gcr.io/webdevelop-dev/yarn:`date +%d%m%Y`

docker build -t gcr.io/webdevelop-dev/yarn:latest .
docker push gcr.io/webdevelop-dev/yarn:latest
