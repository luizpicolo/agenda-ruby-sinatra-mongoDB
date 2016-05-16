require 'mongo'
require 'mongo_mapper'

# Configuration MongoDB
configure do
  # Heroku Connection
  if ENV['MONGOHQ_URL']
    uri = URI.parse(ENV['MONGOHQ_URL'])
    MongoMapper.connection = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
    MongoMapper.database = uri.path.gsub(/^\//, '')
    puts ">> db is #{uri.path.gsub(/^\//, '')}"
  else
    # Local connection
    MongoMapper.database = 'phone_book'
  end
end

require_relative 'phone_book.rb'
