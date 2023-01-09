# How to run SQL query in Snowflake using the statement REST api and JWT token

Reference: <https://docs.snowflake.com/en/_downloads/aeb84cdfe91dcfbd889465403b875515/sql-api-generate-jwt.py>

Discussed below 2 options, 
1. using *snowcli* and *curl* 
2. using python script

## Prerequisite

Setting up key based authentication for a snowflake  user
- authenticating user should have the required key configured so that JWT token generation can complete with the key based auth,
 - you can use the gen-rsa-keypair.sh script to generate the rsa key pair
- use the below command to update the public key pair rsa_key.pub to the specific user AIRBYTE_USER

 `alter user AIRBYTE_USER set rsa_public_key='eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJBTEdXQ0hSLVFRMDA1NDQuQUlSQllURV9VU0VSLlNIQTI1NjphY0xtaW5RSkNvTG9GRzRpUzVsdzhMU3B2Q0g0SlJFTXJDNGRGUlFPR1NZPSIsInN1YiI6IkFMR1dDSFItUVEwMDU0NC5BSVJCWVRFX1VTRVIiLCJpYXQiOjE2NzE5NjgzMTAsImV4cCI6MTY3MjA1NDcxMH0.Jqsjf1rvcD7D1ZYu7SJ9qGXO6_zikQBsyBxhm1krViFQC_okIzQBkRzIlpirUXlOd9OoFjO35LxndWlYA8Rf6Z4x7Di3Riw55hLos4UJvHbj8F3uzOYYaKY29ESSivqjQAHmMfqa7h3WB2_pL76wyTVZ3b_i7NC8Ub9Vt4FiuaI0AZO0kbrJ3nbu05aCGS1y9XeI7UWS59IU2bG3BxK4rmxNCnhPWf_TOPBONOI9_1AvoGP7JIL6Ot8-FKiBPqWxuglGjTFiibVieVa-GDiwb702Z0H6XzVmOgq7m9HcwubeM53XlMnTf8_qjOujHfb-poWtLpPaRtcQFkzWI3Ppnw’`


## Option#1
- Install *snowsql CLI* 
- copy t


## Option#2

- build the python container with the required dependencies
and copy the sample python script snow-sql-api-with-jwt.py which generate jwt token and execute the
- snowflake query defined in the request-body.json file using the statements REST api endpoint.


- Note: currently the account, url, user details are hardcoded in th Docker file, you can change the script and rebuild to point to your required endpoint the private key pair for auth should also be copied.

*/usr/src/app/snow-sql-api-with-jwt.py","--account", "algwchr-rr00544", "--user", "AIRBYTE_USER", "--private_key_file_path", "/usr/src/app/rsa_key.p8", "--end_point_url", "https://algwchr-rr00544.snowflakecomputing.com:443/api/v2/statements* 

- docker build command
`docker build -t sf-sql-req .`

- docker create container to execute the sql query
`docker run -it --rm --name sf-test sf-sql-req`

