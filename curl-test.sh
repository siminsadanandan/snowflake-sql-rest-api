#!/bin/bash

# Required query to be added to the file request-body.json which is in the 
# same directory as this script

SNOWFLAKE_ACCOUNT=algwchr-rr00544
USR=AIRBYTE_USER
WH=AIRBYTE_WAREHOUSE
DB=AIRBYTE_DATABASE
SCHEMA=AIRBYTE
PK_PATH=/Users/sisadana/Documents/my-home/snowflake/rsa_key.p8
API_ENDPOINT="https://${SNOWFLAKE_ACCOUNT}.snowflakecomputing.com:443/api/v2/statements"

# Generate jwt token using snowcli
JWT_TOKEN=$(echo '\n'|snowsql -a $SNOWFLAKE_ACCOUNT -u $USR -w $WH -d $DB -s $SCHEMA --generate-jwt --private-key-path $PK_PATH)


curl -i -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $JWT_TOKEN" \
    -H "Accept: application/json" \
    -H "User-Agent: myApplicationName/1.0" \
    -H "X-Snowflake-Authorization-Token-Type: KEYPAIR_JWT" \
    -d "@request-body.json" \
  "${API_ENDPOINT}"
