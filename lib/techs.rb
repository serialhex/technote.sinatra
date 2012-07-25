# techs db stuff

require "./lib/databaser"

class Techs < DataBaser
  def initialize
    super
    @techs = @@db["techs"]
  end
  
  def method_missing(m, *args, &block)
    @techs.send(m, *args, &block)
  end
  
end