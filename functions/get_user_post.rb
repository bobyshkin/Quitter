# frozen_string_literal: true

require 'aws-sdk-dynamodb'
require 'logger'

def get_item_from_table(dynamodb_client, table_item)
  result = dynamodb_client.get_item(table_item)
  puts "#{result.item['title']} (#{result.item['user_id'].to_i}):"
  puts "  Message: #{result.item['info']['message']}"
  puts "  Rating: #{result.item['info']['rating'].to_i}"
rescue StandardError => e
  logger = Logger.new($stdout)
  logger.info("Error getting movie '#{table_item[:key][:title]} " \
        "(#{table_item[:key][:user_id]})': #{e.message}")
end

def get_user_post(region = 'us-east-1', table_name, user_id, title)

  logger = Logger.new($stdout)
  dynamodb_client = Aws::DynamoDB::Client.new(region: region)

  table_item = {
    table_name: table_name,
    key: {
      user_id: user_id,
      title: title
    }
  }

  logger.info("Getting information about '#{title} (#{user_id})' " \
    "from table '#{table_name}'...")
  get_item_from_table(dynamodb_client, table_item)
end

table_name = 'quitter-posts'
user_id = 1001
title = 'The Long Read Post'

get_user_post(table_name, user_id, title) if $PROGRAM_NAME == __FILE__
