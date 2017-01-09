#!/bin/bash

rm -f ./.env

regex='(https?:\/\/(www\.)?[-a-zA-Z0-9]{2,256}\.[a-z]{2,6})|((https?:\/\/)?([0-9]{1,3}\.){3}([0-9]{1,3}))(\:?[0-9]{1,5})?(\/)?'

while true
do
    read -ra peer -p "Riak host (should be available for other nodes) with protocol and port (default is 8098) : "
    peer=${peer,,}
    echo $peer
    if [[ ! $peer =~ $regex ]]; then
        echo "Error: address [$peer] is not valid!"
        continue
    else
        break
    fi
done

peer=${peer#http://}
peer=${peer#https://}

echo "RIAK_HOST=$peer" >> ./.env
