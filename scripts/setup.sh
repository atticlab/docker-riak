#!/bin/bash

rm ./.env

regex='https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)'

while true
do
    read -ra peer -p "Riak host (should be available for other nodes) : "
    peer=${peer,,}
    if [[ ! $peer =~ $regex ]]
    then
        echo "Error: address [$peer] is not valid!"
        continue
    else
        break
    fi
done

peer=${peer#http://}
peer=${peer#https://}

echo "RIAK_HOST=$peer" >> ./.env