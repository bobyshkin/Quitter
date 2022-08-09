# frozen_string_literal: true

require 'sinatra'
require_relative 'aws_lambda_invoker'

get '/' do
  erb :index
end

get '/upload' do
  invoke_lambda('upload_file_to_s3', 'some_goes_here_payload')
end

get '/publish' do
  # GET User receive request form
  erb :index, layout: :publish, locals: {
    title: 'Post',
    subtitle: 'Subtitle',
    content: 'Content'
  }
end

put '/publish' do
  # PUT User data being posted
end

get '/:user' do |value|
  "Value: #{value}"
end
