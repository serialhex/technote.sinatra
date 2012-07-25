# MongoDB database parent class...

require "mongo"

class DataBaser
  def initialize
    @@conn = Mongo::Connection.new("localhost", 27017)
    @@db = @@conn.db('test')
  end
  
  
end