# README #

# System prerequisites
- Debian 8
- Git

Run `./scripts/prerequisites.sh` to install all other dependencies

# How to start riak nodes

* `make build (external host with protocol or ipv4)`
* `make join 'hostname'` - to join cluster
* `make commit` - to commit pending changes to cluster
* `make status` - to check cluster status

# How to enable security
There is two ways of security:
* `make secure` -- to enable basic password auth in Riak
* when 1st time `make build` -- answer 'yes' to use SSL

# How to enable riak-counters functionality

* `make counters` -- to enable counters bucket type
* `make counters-status` -- to check if the counters is already enabled