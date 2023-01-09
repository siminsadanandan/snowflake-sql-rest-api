FROM python:3

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . /usr/src/app

RUN chmod +x -R /usr/src/app/
CMD [ "python3", "/usr/src/app/snow-sql-api-with-jwt.py","--account", "algwchr-rr00544", "--user", "AIRBYTE_USER", "--private_key_file_path", "/usr/src/app/rsa_key.p8", "--end_point_url", "https://algwchr-rr00544.snowflakecomputing.com:443/api/v2/statements", "--req_file_name", "/usr/src/app/request-body.json" ]
