class Plane

  def initialize
    @flying = true
  end

  def take_off
    raise "Plane already inflight" if @flying
  end

  def land(airport)
    raise "Plane has already landed" unless @flying

    @flying = false
    @airport = airport
  end

  def airport
    raise "Plane is inflight" if @flying

    @airport
  end

end
