#!/usr/bin/env bash

function create_functions() {
  echo "######## Creating AWS Lambda Function #########"
  echo "FunctionName: ${1}"
  echo "Runtime: ${2}"
  echo "Handler: ${4}"
  echo "Role: ${5}"
  echo "Command:"
  set -x
  zip "${3}" "${1}.rb"
  aws lambda create-function \
  --function-name "${1}" \
  --runtime "${2}" \
  --zip-file fileb://"${3}" \
  --handler "${4}" \
  --role "${5}"
  set +x
  rm -v "${3}"
  echo "#################### Done #####################"
}

func_name='quitter-publish'
runtime='ruby2.7'
zip_file="${func_name}.zip"
handler="${func_name}.publish_user_post"
role='arn:aws:iam::349528314273:role/quitter-lambda-role'

create_functions ${func_name} ${runtime} ${zip_file} ${handler} ${role}
