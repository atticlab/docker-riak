#!/bin/bash

docker exec crypto-riak-node riak-admin bucket-type create counters '{"props":{"datatype":"counter"}}'
docker exec crypto-riak-node riak-admin bucket-type activate counters