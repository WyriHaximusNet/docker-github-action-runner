#!/bin/bash
#
# A simple script to start a Docker container
# and run Testinfra in it
# Original script: https://gist.github.com/renatomefi/bbf44d4e8a2614b1390416c6189fbb8e
# Author: @renatomefi https://github.com/renatomefi
#

set -eEuo pipefail

# The first parameter is a Docker tag or image id
declare -r DOCKER_TAG="$1"

printf "Starting a container for '%s'\\n" "$DOCKER_TAG"

DOCKER_CONTAINER=$(docker run --rm -v "$(pwd)/test:/tests" -v "/var/run/docker.sock:/var/run/docker.sock:ro" -t -d "$DOCKER_TAG")
readonly DOCKER_CONTAINER

# Let's register a trap function, if our tests fail, finish or the script gets
# interrupted, we'll still be able to remove the running container
function tearDown {
    docker rm -f "$DOCKER_CONTAINER" &>/dev/null &
}
trap tearDown EXIT TERM ERR

# Finally, run the tests!
echo "Running test suite"
docker run --rm -t \
    -v "$(pwd)/test:/tests" \
    -v "$(pwd)/tmp/test-results:/results" \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    renatomefi/docker-testinfra:5 \
    --disable-pytest-warnings \
    --verbose --hosts="docker://$DOCKER_CONTAINER"
