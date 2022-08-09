# frozen_string_literal: true

require 'aws-sdk-dynamodb'
require 'logger'

def table_created?(dynamodb_client, table_definition)
  response = dynamodb_client.create_table(table_definition)
  response.table_description.table_status
  true
rescue StandardError => e
  logger = Logger.new($stdout)
  logger.error("Error creating table: #{e.message}")
  'Error'
  false
end

# Full example call:
def create_table(table_name, region = 'us-east-1')
  logger = Logger.new($stdout)
  dynamodb_client = Aws::DynamoDB::Client.new(region: region)

  table_definition = {
    table_name: table_name,
    key_schema: [
      {
        attribute_name: 'user_id',
        key_type: 'HASH'  # Partition key.
      },
      {
        attribute_name: 'title',
        key_type: 'RANGE' # Sort key.
      }
    ],
    attribute_definitions: [
      {
        attribute_name: 'user_id',
        attribute_type: 'N'
      },
      {
        attribute_name: 'title',
        attribute_type: 'S'
      }
    ],
    provisioned_throughput: {
      read_capacity_units: 5,
      write_capacity_units: 5
    }
  }

  logger.info("Creating the table named '#{table_name}'...")
  table_is_created = table_created?(dynamodb_client, table_definition)

  if table_is_created
    logger.info("Table '#{table_name}' created.")
  else
    logger.warn("Table '#{table_name}' not created.")
  end
end
