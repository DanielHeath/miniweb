require 'sinatra'
require './heroku_config'

get '/' do
  redirect '/erb_views'
end

get '/hello' do
  "Hello.<br/> <a href='/goodbye'>Say goodbye</a>"
end

get '/goodbye' do
  "Goodbye.<br/> <a href='/hello'>Say hello</a>"
end

get '/erb_views' do
  erb :sample_view
end

class StoredString
  include Mongoid::Document # Lets it be stored
  field :content, type: String
end

get '/chat' do
  form = "<a href='/'>Home</a><br/><form action='/new_chat_message' method='post'><input name='content'></input><input type='submit' value='submit'></input></form>"
  list = []
  StoredString.each do |s|
    list << "<p>#{s.content}</p>"
  end
  response.headers['Cache-Control'] = 'no-cache'
  form + list.reverse.join
end

post '/new_chat_message' do
  StoredString.create! :content => params['content']
  redirect '/chat'
end
