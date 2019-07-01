class Airport

  def initialize(capacity)
    @capacity = capacity
    @hangar = []
  end

  def land(plane)
    raise "Cannot land plane: airport full" if @hangar.length >= @capacity
    
    @hangar << plane
  end

  def take_off(plane)
  end

end
