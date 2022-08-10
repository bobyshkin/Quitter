#!/usr/bin/env bash

function create_role() {
  aws iam create-role \
  --role-name "${1}" \
  --assume-role-policy-document "${2}"
}

role_name='quitter-lambda-role'
assume_role_policy_document='AWSLambdaBasicExecutionRole'

create_role ${role_name} ${assume_role_policy_document}
