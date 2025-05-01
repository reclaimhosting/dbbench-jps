# DB Benchmarking

Use JPS in [`docker-manifest.yaml`](docker-manifest.yaml) or [`sqldb-manifest.yaml`](sqldb-manifest.yaml) to deploy an envirobnment.

For testing on Docker Engine CE containers, open a terminal in the container and use `docker-compose up` to start the tests.

For standalone SQL container testing, open, open a terminal in the container and run `./dbbench.sh` to start the tests. 
