#!/usr/bin/env bash

# First, remove the old copy of the dependencies from the release folder
rm -r ./build/Release/*.so.*

# And remove the old dependencies from the deps/aws_lambda folder
rm -rf ./deps/aws_lambda
mkdir -p ./deps/aws_lambda

# Now, use ldd to figure out the (presumably newer) dependencies are
for i in `ldd ./build/Release/canvas.node | awk '{print $3}' | grep so`; do
    # Copy them to the deps folder for the next build
    cp $i ./deps/aws_lambda/
    # Copy them to build/Release so the system can find them
    cp $i ./build/Release/
done
