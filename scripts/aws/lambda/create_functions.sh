#!/usr/bin/env bash

function create_functions() {
  aws lambda create-function \
  --function-name "${1}" \
  --runtime "${2}" \
  --zip-file fileb://"${3}" \
  --role "${4}"
}

func_name='create_post'
runtime='ruby2.7'
zip_file='create_post.zip'
role='quitter-lambda-role'

create_functions ${func_name} ${runtime} ${zip_file} ${role}
