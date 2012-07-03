require "mongo"

configure do
  conn = Mongo::Connection.new("localhost", 27017)
  set :mongo_connection, conn
  set :mongo_db,         conn.db('test')
end

get '/collections/?' do
  settings.mongo_db.collection_names
end

helpers do
  # a helper method to turn a string ID
  # representation into a BSON::ObjectId
  def object_id val
    BSON::ObjectId.from_string(val)
  end

  def document_by_id id
    id = object_id(id) if String === id
    settings.mongo_db['test'].
      find_one(:_id => id).to_json
  end
end