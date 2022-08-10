#!/usr/bin/env bash

function create_role() {
  echo "############ Creating AWS IAM Role ############"
  echo "Name: ${1}"
  echo "RolePolicy: ${2}"
  echo "Command:"
  set -x
  aws iam create-role \
  --role-name "${1}" \
  --assume-role-policy-document "${2}"
  set +x
  echo "#################### Done #####################"
}

role_name='quitter-lambda-role'
assume_role_policy_document='AWSLambdaBasicExecutionRole'

create_role ${role_name} ${assume_role_policy_document}
