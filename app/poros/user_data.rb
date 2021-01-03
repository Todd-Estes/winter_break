class UserData
  attr_reader :name

  def initialize(attributes)
    @name = attributes[:name]
    @private = attributes[:private]
  end

  def private?
    @private == true
  end
  
end
