# workorders

require "./lib/databaser"

class Workorders < DataBaser
  def initialize
    super
    @workorders = @@db["workorders"]
    # @workorders.create_index([["workorder-num", Mongo::DESCENDING]], unique: true)
  end

  def next_number
    t = @workorders.find_one(nil, sort: ["workorder", -1])
    t.nil? ? 1 : t["workorder"].to_i.next
  end

  def method_missing(m, *args, &block)
    @workorders.send(m, *args, &block)
  end

  class Workorder
    def initialize(wo)
      @wo = wo
    end
  end

end