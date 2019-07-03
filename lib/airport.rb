class Airport

  def initialize(capacity)
    @capacity = capacity
    @hangar = []
  end

  def land(plane)
    raise "Cannot land plane: airport full" if full?
    raise "Cannot land plane: weather stormy" if stormy?

    @hangar << plane
  end

  def take_off(plane)
  end

  private

  def full?
    @hangar.length >= @capacity
  end

  def stormy?
    rand(1..6) > 4
  end

end
