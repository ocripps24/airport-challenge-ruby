require 'weather_reporter'

class Airport

  DEFAULT_CAPACITY = 20

  def initialize(weather_reporter, capacity = DEFAULT_CAPACITY)
    @weather_reporter = weather_reporter
    @capacity = capacity
    @hangar = []
  end

  def land(plane)
    raise "Cannot land plane: airport full" if full?
    raise "Cannot land plane: weather stormy" if stormy?

    @hangar << plane
  end

  def take_off(plane)
    raise "Cannot take off plane: weather stormy" if stormy?
    raise "Cannot take off: plane not present" unless at_airport?(plane)
    
    plane
  end

  private

  def full?
    @hangar.length >= @capacity
  end

  def stormy?
    @weather_reporter.stormy?
  end

  def at_airport?(plane)
    @hangar.include?(plane)
  end

end
