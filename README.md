# python-client

[![PyPI version](https://img.shields.io/pypi/v/text2motion-client-api)](https://pypi.org/project/text2motion-client-api)
[![Python versions](https://img.shields.io/pypi/pyversions/text2motion-client-api)](https://pypi.org/project/text2motion-client-api)
[![License](https://img.shields.io/pypi/l/text2motion-client-api)](https://github.com/text2motion/python-client/blob/main/LICENSE)

OpenAPI generated Python client package used for making request to Text2Motion API server.

## Getting Started

To install the package:

```bash
python -m pip install text2motion-client-api
```

### Using Text2Motion Client API

After installing text2motion-client-api

Next, obtain an API key from [Developer portal](https://developer.text2motion.ai/get-started).

For full example on how to use the APIs, navigate to the [Download files in pypi and download the Source Distribution](https://pypi.org/project/text2motion-client-api/#files) and open the generated `Readme.md`.

## Development

### Configuration

OpenAPI specification is being read from [api-spec](https://github.com/text2motion/api-spec/).

To modify the API version or any other config, change them in `.env` and commit the change.

### Local build

Docker is requires to run local build. To test building locally, run the following command

```bash
PACKAGE_VERSION=0.1.0 ./generate.sh
```

`PACKAGE_VERSION` could be any version number. It would determine the final `.whl` file name, e.g. above example produces the generated python client under `python-client/` directory, and build directory `dist/` which includes `python-client/dist/text2motion_client_api-0.1.0-py3-none-any.whl`

### Release

When a new release is cut in the format `releases/VERSION_NUMBER`, Github Action will automatically call `generate.sh` and publish to Pypi.
