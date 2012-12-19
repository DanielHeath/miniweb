require 'sinatra'
require './heroku_config'

get '/' do
  redirect '/hello'
end

get '/hello' do
  "Hello.<br/> <a href='/goodbye'>Say goodbye</a>"
end

get '/goodbye' do
  "Goodbye.<br/> <a href='/hello'>Say hello</a>"
end

class StoredString
  include Mongoid::Document # Lets it be stored
  field :content, type: String
end

get '/mongo' do
  form = "<form action='/mongo' method='post'><input name='content'></input><input type='submit' value='submit'></input></form>"
  list = []
  StoredString.each do |s|
    list << "<p>#{s.content}</p>"
  end
  response.headers['Cache-Control'] = 'no-cache'
  form + list.reverse.join
end

post '/mongo' do
  StoredString.create! :content => params['content']
  redirect '/mongo'
end
