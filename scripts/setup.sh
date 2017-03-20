#!/bin/bash

rm -f ./.env

regex='(https?:\/\/(www\.)?[-a-zA-Z0-9]{2,256}\.[a-z]{2,6})|((https?:\/\/)?([0-9]{1,3}\.){3}([0-9]{1,3}))(\:?[0-9]{1,5})?(\/)?'

while true
do
    read -ra peer -p "Riak host (should be available for other nodes): "
    peer=${peer,,}
    echo $peer
    if [[ ! $peer =~ $regex ]]; then
        echo "Error: address [$peer] is not valid!"
        continue
    else
        break
    fi
done

SLL_TARGET_DIR="./docker/riak/ssl-cert/"

while true
do
    read -ra ssl_certfile -p "Enter SSL certfile location path (optional, ENTER to skip): "
    if [[ ! -f $ssl_certfile ]]; then
        echo "Warning: file $ssl_certfile is not exist, ignoring it"
        break
    else
        cp -rf "$ssl_certfile" "$SLL_TARGET_DIR"
        SSL_CERTFILE=$(basename $ssl_certfile)
        echo "SSL_CERTFILE=$SSL_CERTFILE" >> ./.env
        break
    fi
done

while true
do
    read -ra ssl_keyfile -p "Enter SSL keyfile location path (optional, ENTER to skip): "
    if [[ ! -f $ssl_keyfile ]]; then
        echo "Warning: file $ssl_keyfile is not exist, ignoring it"
        break
    else
        cp -rf "$ssl_keyfile" "$SLL_TARGET_DIR"
        SSL_KEYFILE=$(basename $ssl_keyfile)
        echo "SSL_KEYFILE=$SSL_KEYFILE" >> ./.env
        break
    fi
done

while true
do
    read -ra ssl_cacert -p "Enter SSL CA cert file location path (optional, ENTER to skip): "
    if [[ ! -f $ssl_cacert ]]; then
        echo "Warning: file $ssl_cacert is not exist, ignoring it"
        break
    else
        cp -rf "$ssl_cacert" "$SLL_TARGET_DIR"
        SSL_CACERT=$(basename $ssl_cacert)
        echo "SSL_CACERT=$SSL_CACERT" >> ./.env
        break
    fi
done


peer=${peer#http://}
peer=${peer#https://}

echo "RIAK_HOST=$peer" >> ./.env
