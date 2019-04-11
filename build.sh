#!/bin/bash

set -e

printf "Building gcr.io/nioinstances/meteor-base:latest\n"

docker build -t gcr.io/nioinstances/meteor-base:latest .
