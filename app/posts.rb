# frozen_string_literal: true

require 'aws-sdk-dynamodb'
require_relative 'aws_lambda_invoker'
require 'date'

class Posts
  def self.table_scan(region = 'us-east-1')
    table_name = 'quitter-posts'
    dynamodb_client = Aws::DynamoDB::Client.new(region: region)
    dynamodb_client.scan({ table_name: table_name })
  rescue StandardError => e
    puts(e.message)
  end

  def self.get
    result = table_scan
    result['items'].each do |item|
      item['date'] = DateTime.parse(item['date'])
    end
    result['items'].sort_by! { |h| h['date'] }.reverse!
  end

  def self.put(user_id, message)
    payload = { user_id: user_id, message: message }
    Invoker.invoke('quitter-publish', payload)
  end
end
