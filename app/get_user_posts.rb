# frozen_string_literal: true

require 'aws-sdk-dynamodb'
require 'logger'

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
    result['items'].to_a.map { |post| post }
  end
end
