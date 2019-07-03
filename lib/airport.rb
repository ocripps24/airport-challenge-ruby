class Airport

  def initialize(capacity)
    @capacity = capacity
    @hangar = []
  end

  def land(plane)
    raise "Cannot land plane: airport full" if full?

    @hangar << plane
  end

  def take_off(plane)
  end

  private
  
  def full?
    @hangar.length >= @capacity
  end

end
