#!/bin/bash
set -e
source .env

BUILD_CONTAINER_NAME=t2m-python-client-builder

if [ -z "$PACKAGE_VERSION" ]; then
    echo "PACKAGE_VERSION is required in the environment, e.g. PACKAGE_VERSION=0.1.0 ./generate.sh. Cancelling."
    exit 1
fi

echo "Python Package Version: ${PACKAGE_VERSION}"
echo "API Spec Version: ${API_SPEC_VERSION}"
echo "OpenAPI Generator CLI Version: ${OPENAPI_GENERATOR_CLI_VERSION}"


# https://openapi-generator.tech/docs/generators/python/
echo "Generating Python client using OpenAPI Generator cli..."
rm -rf python-client
mkdir python-client
docker run --user $(id -u):$(id -g) --rm -v "${PWD}:/local" openapitools/openapi-generator-cli:${OPENAPI_GENERATOR_CLI_VERSION} generate \
    -i https://raw.githubusercontent.com/text2motion/api-spec/refs/tags/releases/${API_SPEC_VERSION}/spec.yaml \
    -g python \
    -o /local/python-client \
    --additional-properties packageName=text2motion_client_api,packageVersion=${PACKAGE_VERSION}

echo "Patching the generated build configuration..."
file=$( < python-client/setup.py )
search=$( < patches/setup-search.py )
replacement=$( < patches/setup-replace.py )
printf '%s\n' "${file/"$search"/$replacement}" > python-client/setup.py

echo "Prepend the README.md with patches/README-notes.md file"
sed -i -e '1rpatches/README-notes.md' -e '1{h;d}' -e '2{x;G}' python-client/README.md

echo "Building the Python client..."
docker build -t $BUILD_CONTAINER_NAME . -f Dockerfile
docker run \
    --user $(id -u):$(id -g) \
    --rm \
    -v ${PWD}:/local \
    $BUILD_CONTAINER_NAME \
    python3 -m build --sdist /local/python-client --wheel
