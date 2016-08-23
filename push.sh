#!/bin/bash

# authenticate to docker hub and push the new image
if [ "$TRAVIS_BRANCH" == "master" ]; then
  docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
  docker push watzek/omeka;
fi
