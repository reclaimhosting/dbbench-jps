# DB Benchmarking

Use JPS in [`docker-manifest.yaml`](docker-manifest.yaml) or [`sqldb-manifest.yaml`](sqldb-manifest.yaml) to deploy an envirobnment.

## Docker Engine CE Container
- You can edit the version of MySQL used by changing the tag on line 3 in the `docker-compose.yml` file with [another valid one from DockerHub](https://hub.docker.com/_/mysql/tags).

## Standalone DB container
- You can edit the version of the container deployed by changing the nodeType and tag on lines 10-11 in the JPS before deploying it. You'll want to replace those values with a valid one found in **JCA** > **Templates**.

## Run a test
- Open a terminal in the container and run `./dbbench.sh` to start the tests.
- Or run it and log it too: `./dbbench.sh | tee $(date --iso-8601).log`
