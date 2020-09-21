#! /bin/bash -ex
cleanup () {
  docker images -q json_api_client:latest | xargs docker rmi
}
trap cleanup EXIT

docker build -t json_api_client:latest .
docker run --rm json_api_client:latest ci
