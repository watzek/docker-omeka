#!/bin/bash

# authenticate to docker hub and push the new image
if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
  docker push watzek/omeka;
fi
