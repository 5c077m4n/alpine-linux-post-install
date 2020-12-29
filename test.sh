#!/bin/sh

linux_flavor="${1:-'alpine'}"

docker build -f "./test-files/${linux_flavor}/Dockerfile" -t setup_test
docker run setup_test --name setup_test --rm
