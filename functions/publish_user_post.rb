# frozen_string_literal: true

require 'aws-sdk-dynamodb'
require 'logger'

def add_item_to_table(dynamodb_client, table_item)
  logger = Logger.new($stdout)
  dynamodb_client.put_item(table_item)
  logger.info("Published post: '#{table_item[:item][:title]}'; " \
    "User: #{table_item[:item][:user_id]}.")
rescue StandardError => e
  logger = Logger.new($stdout)
  logger.error("Error publishing post: '#{table_item[:item][:title]}'; " \
    "User: #{table_item[:item][:user_id]}: #{e.message}")
end

def publish_user_post(region = 'us-east-1', table_name, user_id, title, message, rating)

  logger = Logger.new($stdout)
  dynamodb_client = Aws::DynamoDB::Client.new(region: region)

  table_item = {
    table_name: table_name,
    item: {
      user_id: user_id,
      title: title,
      post: {
        message: message,
        rating: rating
      }
    }
  }

  logger.info("Publishing post: '#{table_item[:item][:title]}'; " \
    "User: #{table_item[:item][:user_id]} " \
    "to table '#{table_name}'...")
  add_item_to_table(dynamodb_client, table_item)
end

table_name = 'quitter-posts'
user_id = 'King Julien'
title = 'Little Froggy'
message = 'Excuse me, little froggy. I believe you are a little confussed. I am the one who is telling the other animals what to do.'
rating = 5.0


publish_user_post(table_name, user_id, title, message, rating) if $PROGRAM_NAME == __FILE__
