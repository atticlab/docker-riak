#!/bin/bash

###########################
## Available permissions ##
###########################

#riak_kv.get             Retrieve objects
#riak_kv.put             Create or update objects
#riak_kv.delete          Delete objects
#riak_kv.index           Index objects using secondary indexes (2i)
#riak_kv.list_keys       List all of the keys in a bucket
#riak_kv.list_buckets    List all buckets

#search.admin            The ability to perform search admin-related tasks, such as creating and deleting indexes and adding and modifying search schemas
#search.query            The ability to query an index

#riak_core.get_bucket        Retrieve the props associated with a bucket
#riak_core.set_bucket        Modify the props associated with a bucket
#riak_core.get_bucket_type   Retrieve the set of props associated with a bucket type
#riak_core.set_bucket_type   Modify the set of props associated with a bucket type

docker exec crypto-riak-node riak-admin security grant riak_kv.get,riak_kv.put,riak_kv.delete,riak_kv.index,search.query on any to all
docker exec crypto-riak-node riak-admin security add-source all 0.0.0.0/0 password
docker exec crypto-riak-node riak-admin security enable