# workorders

require "./lib/databaser"

class Workorders < DataBaser
  def initialize
    super
    @workorders = @@db["workorders"]
  end
  
  def method_missing(m, *args, &block)
    @workorders.send(m, *args, &block)
  end
  
end