#!/bin/bash
set -e
source .env

if [ -z "$PACKAGE_VERSION" ]; then
    echo "PACKAGE_VERSION is required in the environment, e.g. PACKAGE_VERSION=0.1.0 ./generate.sh. Cancelling."
    exit 1
fi

echo "Python Package Version: ${PACKAGE_VERSION}"
echo "API Spec Version: ${API_SPEC_VERSION}"
echo "OpenAPI Generator CLI Version: ${OPENAPI_GENERATOR_CLI_VERSION}"


# https://openapi-generator.tech/docs/generators/python/
rm -rf python-client
mkdir python-client
docker run --user $(id -u):$(id -g) --rm -v "${PWD}:/local" openapitools/openapi-generator-cli:${OPENAPI_GENERATOR_CLI_VERSION} generate \
    -i https://raw.githubusercontent.com/text2motion/api-spec/refs/tags/releases/${API_SPEC_VERSION}/spec.yaml \
    -g python \
    -o /local/python-client \
    --additional-properties packageName=text2motion_client_api,packageVersion=${PACKAGE_VERSION}

rm -rf wheels
mkdir wheels
docker run --user $(id -u):$(id -g) --rm -v ${PWD}:/local python:3.11-slim \
    pip wheel /local/python-client -w /local/wheels
