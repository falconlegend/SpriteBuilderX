#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"
cd ..

# Use the latest tag for short version (expected tag format "vn[.n[.n]]")
# or if there are no tags, we make up version 0.0.<commit count>
LATEST_TAG=$(git describe --tags --match 'ver_*' --abbrev=0 2>/dev/null) || LATEST_TAG="HEAD"
if [ $LATEST_TAG = "HEAD" ]
then COMMIT_COUNT=$(git rev-list --count HEAD)
    LATEST_TAG="0.0.$COMMIT_COUNT"
    COMMIT_COUNT_SINCE_TAG=0
else
    COMMIT_COUNT_SINCE_TAG=$(git rev-list --count ${LATEST_TAG}..)
    LATEST_TAG=${LATEST_TAG##ver_} # Remove the "ver_" from the front of the tag
fi

SHORT_VERSION="${LATEST_TAG}.${COMMIT_COUNT_SINCE_TAG}"

echo $SHORT_VERSION