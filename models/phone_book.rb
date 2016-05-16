require 'mongo_mapper'

class PhoneBook
  include MongoMapper::Document

  key :name, String, required: true
  key :phone, String, required: true
  timestamps!
end
