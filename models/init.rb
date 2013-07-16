require 'mongo'
require 'mongo_mapper'

#configuração do MongoDB
configure do
  
  # Conexão Local
  #MongoMapper.database = 'agenda'
  
  # Conexão com Heroku
  if ENV['MONGOHQ_URL']
    uri = URI.parse(ENV['MONGOHQ_URL'])
    MongoMapper.connection = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
    MongoMapper.database = uri.path.gsub(/^\//, '')
    puts ">> db is #{uri.path.gsub(/^\//, '')}"
  end
  
end

require_relative 'agenda.rb'