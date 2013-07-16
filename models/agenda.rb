require 'mongo_mapper'

class Agenda
  
  include MongoMapper::Document

  key :nome, String, :required => true
  key :telefone, String, :required => true
  timestamps!
  
end