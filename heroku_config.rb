require 'mongoid'

Mongoid.configure do |config|
  if ENV['MONGOHQ_URL']
    Mongoid.load!("config/mongo.yml", :production)
  else
    Mongoid.load!("config/mongo.yml", :development)
  end
end

