require 'weather_reporter'

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
    raise "Cannot take off plane: weather stormy" if stormy?
  end

  private

  def full?
    @hangar.length >= @capacity
  end

  def stormy?
    WeatherReporter.stormy?
  end

end
