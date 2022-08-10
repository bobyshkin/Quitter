#!/usr/bin/env bash

function update_functions() {
  echo "######## Updating AWS Lambda Function #########"
  echo "FunctionName: ${1}"
  echo "Command:"
  set -x
  zip "${2}" "${1}.rb"
  aws lambda update-function-code \
  --function-name "${1}" \
  --zip-file fileb://"${2}"
  set +x
  rm -v "${2}"
  echo "#################### Done #####################"
}

func_name='quitter-publish'
zip_file="${func_name}.zip"

update_functions ${func_name} ${zip_file}
