# frozen_string_literal: true

require 'sinatra'
require_relative 'posts'

get '/' do
  erb :index
end

post '/publish' do
  Posts.put(params[:username], params[:text])
  redirect '/'
end

get '/upload' do
  invoke_lambda('upload_file_to_s3', 'some_goes_here_payload')
end

get '/styles.css' do
  sass :styles
end
