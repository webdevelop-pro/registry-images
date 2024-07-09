COMPANY_NAME=webdevelop-pro
SERVICE_NAME=php

case $1 in

*)
  BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`
  GIT_COMMIT=`git rev-parse --short HEAD`
  echo $BRANCH_NAME, $GIT_COMMIT
  docker build -t webdeveloppro/$SERVICE_NAME:v8.2 -t webdeveloppro/$SERVICE_NAME:latest-dev --platform=linux/amd64 .
  # snyk container test cr.webdevelop.us/$COMPANY_NAME/$SERVICE_NAME:$GIT_COMMIT
  if [ $? -ne 0 ]; then
    echo "===================="
    echo "snyk has found a vulnerabilities, please consider choosing alternative image from snyk"
    echo "===================="
    return
  fi
  docker push webdeveloppro/$SERVICE_NAME:latest-dev
  docker push webdeveloppro/$SERVICE_NAME:v8.2
  ;;

esac

