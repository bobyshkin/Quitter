# frozen_string_literal: true

require 'sinatra'
require_relative 'get_user_posts'
require_relative 'aws_lambda_invoker'

get '/' do
  erb :index
end

get '/upload' do
  invoke_lambda('upload_file_to_s3', 'some_goes_here_payload')
end

put '/publish' do
  User[session[:user]].tweet(params[:text])
  redirect '/'
end

get '/styles.css' do
  sass :styles
end
