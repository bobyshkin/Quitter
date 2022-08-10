# frozen_string_literal: true

require 'aws-sdk-dynamodb'
require 'logger'

TABLE_NAME = 'quitter-posts'

def add_item_to_table(dynamodb_client, table_item)
  logger = Logger.new($stdout)
  dynamodb_client.put_item(table_item)
  logger.info("Published post: '#{table_item[:item][:date]}'; " \
    "User: #{table_item[:item][:user_id]}.")
rescue StandardError => e
  logger = Logger.new($stdout)
  logger.error("Error publishing post: '#{table_item[:item][:date]}'; " \
    "User: #{table_item[:item][:user_id]}: #{e.message}")
end

def publish_user_post(event:, context:)
  logger = Logger.new($stdout)
  region = 'us-east-1'
  dynamodb_client = Aws::DynamoDB::Client.new(region: region)

  table_item = {
    table_name: TABLE_NAME,
    item: {
      user_id: event['user_id'],
      date: DateTime.now.iso8601,
      post: {
        message: event['message'],
        rating: 5.0 # TODO: remove this
      }
    }
  }

  logger.info("Publishing post: '#{table_item[:item][:date]}'; " \
    "User: #{table_item[:item][:user_id]} " \
    "to table '#{TABLE_NAME}'...")
  add_item_to_table(dynamodb_client, table_item)
end
