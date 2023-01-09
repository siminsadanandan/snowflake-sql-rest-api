# To generate jwt token using snowcli
#JWT_TOKEN=$(echo '\n'|snowsql -a algwchr-rr00544 -u AIRBYTE_USER -w AIRBYTE_WAREHOUSE -d AIRBYTE_DATABASE -s AIRBYTE --generate-jwt --private-key-path /Users/sisadana/Documents/my-home/snowflake/rsa_key.p8)

curl -i -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $JWT_TOKEN" \
    -H "Accept: application/json" \
    -H "User-Agent: myApplicationName/1.0" \
    -H "X-Snowflake-Authorization-Token-Type: KEYPAIR_JWT" \
    -d "@request-body.json" \
  "https://algwchr-rr00544.snowflakecomputing.com:443/api/v2/statements"
