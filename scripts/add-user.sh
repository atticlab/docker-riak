#!/bin/bash

LOGIN=""
PASSWORD=""
while true
do
    read -ra LOGIN -p "Username: "
    LOGIN=${LOGIN,,}
    if [[ $LOGIN == '' ]]; then
        echo "Error: username cannot be empty!"
    else
        break
    fi
done

while true
do
    read -ra PASSWORD -p "Password: "
    if [[ $PASSWORD == '' ]]; then
        echo "Password cannot be empty!"
    else
        break
    fi
done

while true
do
    read -ra pwd -p "Repeat password: "
    if [[ $PASSWORD == $pwd ]]; then
        break
    else
        echo "Passwords do not match!"
    fi
done

docker exec crypto-riak-node riak-admin security add-user $LOGIN password=$PASSWORD