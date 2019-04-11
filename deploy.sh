#!/bin/bash

set -e

echo "pushing gcr.io/nioinstances/meteor-base:latest"

# push the builds
docker push gcr.io/nioinstances/meteor-base:latest
