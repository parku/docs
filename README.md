# Developer Documentation for the ParkU API

Use them as a basic start into developing parku applications.

## Prerequisites

For running the native version on Linux/Mac:

- make
- node
- `npm -g aglio aglio-theme-w00tw00t apib2swagger`

For running the containerized version, you will need

- make
- docker

## Building

For building natively use:
`$ make all`

For building in the container:
`$ make all-in-docker`

The resulting files are in the repository root, you can start browsing using
the index.html file.

## Deployment

We use `gh-pages` for deployment.
