#!/bin/bash

# author: 2021-12-08 shawn.becker@angel.com

# usage create-token.sh [<expire_minutes>]

source .env

EXPIRE_MINUTES=5
if [ "$#" -eq "1" ]; then
  EXPIRE_MINUTES=$1
fi

python3 generate-token.py $ISSUER_ID $KEY_ID $PRIVATE_KEY_PATH $EXPIRE_MINUTES




