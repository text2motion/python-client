# python-client

OpenAPI generated Python client package used for making request to Text2Motion API server.

## Configuration

OpenAPI specification is being read from [api-spec](https://github.com/text2motion/api-spec/).

To modify the API version or any other config, change them in `.env` and commit the change.

## Local build

Docker is requires to run local build. To test building locally, run the following command

```bash
PACKAGE_VERSION=0.1.0 ./generate.sh
```

`PACKAGE_VERSION` could be any version number. It would determine the final `.whl` file name, e.g. above example produces `wheels/text2motion_client_api-0.1.0-py3-none-any.whl`

## Release

When a new release is cut in the format `releases/VERSION_NUMBER`, Github Action will automatically call `generate.sh` and upload the resulting artifact to the release page.
