# frozen_string_literal: true

require 'logger'
require 'json'
require 'aws-sdk-lambda'

class Invoker
  def self.invoked?(function_name, req_payload)
    logger = Logger.new($stdout)
    region = 'us-east-1'
    lambda_client = Aws::Lambda::Client.new(region: region)

    payload = JSON.generate(req_payload)

    logger.info("## Lambda function '#{function_name}' invoked.")
    response = lambda_client.invoke(
      {
        function_name: function_name,
        invocation_type: 'RequestResponse',
        log_type: 'None',
        payload: payload
      }
    )
    if response
      logger.info("Lambda function '#{function_name}' invoked.")
    else
      logger.info("Lambda function '#{function_name}' not invoked.")
    end
  rescue StandardError => e
    puts "Error uploading object: #{e.message}"
    false
  end

  def self.invoke(function_name, payload)
    logger = Logger.new($stdout)
    req_payload = payload
    logger.info("Invoking lambda function '#{function_name}'")
    invoked?(function_name, req_payload)
  end
end
