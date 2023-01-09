# How to run SQL query in Snowflake using the statement REST api and JWT token

Reference: <https://docs.snowflake.com/en/_downloads/aeb84cdfe91dcfbd889465403b875515/sql-api-generate-jwt.py>

Discussed below 2 options, 
1. using *snowcli* and *curl* 
2. using python script

## Prerequisite

Setting up key based authentication for a snowflake  user
-authenticating user should have the required key configured so that JWT token generation can complete with the key based auth
 1. you can use the *gen-rsa-keypair.sh* script to generate the rsa key pair
2. use the below SQL to update the public key *rsa_key.pub* for a specific user, in the example here it is updating *AIRBYTE_USER* user

 `alter user AIRBYTE_USER set rsa_public_key='eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJBTEdXQ0hSLVFRMDA1NDQuQUlSQllURV9VU0VSLlNIQTI1NjphY0xtaW5RSkNvTG9GRzRpUzVsdzhMU3B2Q0g0SlJFTXJDNGRGUlFPR1NZPSIsInN1YiI6IkFMR1dDSFItUVEwMDU0NC5BSVJCWVRFX1VTRVIiLCJpYXQiOjE2NzE5NjgzMTAsImV4cCI6MTY3MjA1NDcxMH0.Jqsjf1rvcD7D1ZYu7SJ9qGXO6_zikQBsyBxhm1krViFQC_okIzQBkRzIlpirUXlOd9OoFjO35LxndWlYA8Rf6Z4x7Di3Riw55hLos4UJvHbj8F3uzOYYaKY29ESSivqjQAHmMfqa7h3WB2_pL76wyTVZ3b_i7NC8Ub9Vt4FiuaI0AZO0kbrJ3nbu05aCGS1y9XeI7UWS59IU2bG3BxK4rmxNCnhPWf_TOPBONOI9_1AvoGP7JIL6Ot8-FKiBPqWxuglGjTFiibVieVa-GDiwb702Z0H6XzVmOgq7m9HcwubeM53XlMnTf7_qjOujHfb-poWtLpPaRtcQFkzWI3Ppnw’`


## Option#1
- Install *snowsql CLI*, follow doc <https://docs.snowflake.com/en/user-guide/snowsql-install-config.html>
- Run *curl-test.sh* script after updating the required params in the script and the associated request payload file *request-body.json*
		- you can change the SQL in the *request-body.json* file, if you want to use bind variable you have provide the value to the bind variables in *bindings* section of this json file.


## Option#2
Run the python script to generate JWT token and submit the statements API request. In the example below we are running the python script *snow-sql-api-with-jwt.py* inside a custom docker container which has all the required packages installed.
- build the python docker image with all the required dependencies and copy the required files including python *script snow-sql-api-with-jwt.py*
- snowflake query defined in the request-body.json file using the statements REST api endpoint

*Note: currently the account, url, user details are hardcoded in the Docker file (CMD section), you can change the values and rebuild to point to your required endpoint, the private key pair for auth should also be copied. to the docker build folder before building. You can change the SQL in the *request-body.json* file, if you want to use bind variable you have provide the value to the bind variables in *bindings* section of this json file.*

- docker build command
`docker build -t sf-sql-req .`

- docker command to execute the SQL query using the REST API call
`docker run -it --rm --name sf-test sf-sql-req`

