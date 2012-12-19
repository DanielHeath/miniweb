require 'sinatra'

get '/' do
  redirect '/hello'
end

get '/hello' do
  "Hello.<br/> <a href='/goodbye'>Say goodbye</a>"
end

get '/goodbye' do
  "Goodbye.<br/> <a href='/hello'>Say hello</a>"
end

