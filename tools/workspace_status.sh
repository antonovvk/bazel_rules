#!/bin/sh -e

GIT_BRANCH=`git describe --all`
GIT_TAG=`git describe --always --dirty`

echo "STABLE_GIT_TAG $GIT_TAG on $GIT_BRANCH"
echo "STABLE_BUILD_DATE `date`"
