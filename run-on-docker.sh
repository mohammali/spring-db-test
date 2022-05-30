#!/bin/bash

set -e

IMAGE_NAME=spring-db-test
IMAGE_NAME_PROFILE="${IMAGE_NAME}:prod"

remove_docker_container() {
  # shellcheck disable=SC2046
  docker rm $(docker stop $(docker ps -a -q --filter ancestor=${IMAGE_NAME_PROFILE} --format="{{.ID}}")) || echo error
}

remove_image() {
  docker rmi ${IMAGE_NAME_PROFILE} || echo error
}

build_application() {
    mvn clean install -Dmaven.test.skip=true -Dfindbugs.skip=true
}

build_docker_image() {
    docker build -t ${IMAGE_NAME_PROFILE} .
}

execute_docker_compose() {
  # shellcheck disable=SC2046
  docker run -i \
  -e ACTIVE_PROFILES=prod \
  -e DB_NAME=test2_db \
  -e DB_USER=test_user \
  -e DB_PASSWORD=123123123 \
  -e DB_HOST=host.docker.internal \
  -e DB_PORT=5432 \
  -p 3333:8080 \
  ${IMAGE_NAME_PROFILE}

}

main() {
  build_application
  remove_docker_container
  remove_image
  build_docker_image
  execute_docker_compose
}

main
