#!/usr/bin/env ruby
# frozen_string_literal: true

require 'aws-sdk-s3'
require 'logger'

def object_uploaded?(s3_client, bucket_name, object_key)
  response = s3_client.put_object(
    bucket: bucket_name,
    key: object_key
  )
  if response.etag
    true
  else
    false
  end
rescue StandardError => e
  logger = Logger.new($stdout)
  logger.error("Error uploading object: #{e.message}")
  false
end

def upload_object(bucket_name, object_key)
  logger = Logger.new($stdout)
  region = 'us-east-1'
  s3_client = Aws::S3::Client.new(region: region)
  logger.info("Uploading object '#{object_key}' to bucket '#{bucket_name}' ...")
  if object_uploaded?(s3_client, bucket_name, object_key)
    logger.info("Object '#{object_key}' uploaded to bucket '#{bucket_name}'.")
  else
    logger.warn("Object '#{object_key}' not uploaded to bucket '#{bucket_name}'.")
  end
end

bucket_name = 'test-maxiasvasd'
object_key = 'create_post.log'

upload_object(bucket_name, object_key)
