#!/usr/bin/env bash

function update_functions() {
  aws lambda update-function \
  --function-name "${1}" \
  --zip-file fileb://"${2}"
}

func_name='create_post'
zip_file='create_post.zip'

update_functions ${func_name} ${zip_file}
