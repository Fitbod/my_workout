#!/bin/bash

set -ex

docker build -t my_workout -f Dockerfile .
docker tag my_workout:latest fitbodinc/my_workout:0.1.0
docker push fitbodinc/my_workout:0.1.0
