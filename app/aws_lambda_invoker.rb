# frozen_string_literal: true

require 'logger'
require 'json'
require 'aws-sdk-lambda'

class Invoker
  def self.invoked?(function_name)
    logger = Logger.new($stdout)
    region = 'us-east-1'
    lambda_client = Aws::Lambda::Client.new(region: region)

    # Get the 10 most recent items
    req_payload = {:SortBy => 'time', :SortOrder => 'descending', :NumberToGet => 10}
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
    if response.etag
      logger.info("Lambda function '#{function_name}' invoked.")
    else
      logger.info("Lambda function '#{function_name}' not invoked.")
    end
  rescue StandardError => e
    puts "Error uploading object: #{e.message}"
    false
  end

  def self.invoke(function_name)
    logger = Logger.new($stdout)
    logger.info("Invoking lambda function '#{function_name}'")
    invoked?(function_name)
  end
end
