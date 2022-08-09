# frozen_string_literal: true

require 'logger'
require 'json'
require 'aws-sdk-lambda'

def lambda_invoked?(lambda_client, function_name)
  logger = Logger.new($stdout)
  logger.info("## Lambda function '#{function_name}' invoked.")
  response = lambda_client.invoke(
    {
      function_name: function_name,
      invocation_type: 'RequestResponse',
      log_type: 'None'
      # payload: payload
    }
  )
  if response.etag
    true
  else
    false
  end
rescue StandardError => e
  puts "Error uploading object: #{e.message}"
  false
end

def invoke_lambda
  logger = Logger.new($stdout)
  region = 'us-east-1'
  lambda_client = Aws::Lambda::Client.new(region: region)
  logger.info("Invoking lambda function '#{function_name}'")
  if lambda_invoked?(lambda_client, function_name)
    logger.info("Lambda function '#{function_name}' invoked.")
  else
    logger.info("Lambda function '#{function_name}' not invoked.")
  end
end
