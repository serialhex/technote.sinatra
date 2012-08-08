# workorders

require "./lib/databaser"

class Workorders < DataBaser
  def initialize
    super
    @workorders = @@db["workorders"]
    # @workorders.create_index([["workorder-num", Mongo::DESCENDING]], unique: true)
  end

  def next_number
    @workorders.find_one(nil, sort: ["workorder", -1])["workorder"].next.to_i
  end
  
  def method_missing(m, *args, &block)
    @workorders.send(m, *args, &block)
  end
  
end