require_relative 'weather_reporter'
require_relative 'plane'

class Airport

  DEFAULT_CAPACITY = 20

  attr_reader :hangar

  def initialize(weather_reporter, capacity = DEFAULT_CAPACITY)
    @weather_reporter = weather_reporter
    @capacity = capacity
    @hangar = []
  end

  def land(plane)
    raise "Cannot land plane: airport full" if full?
    raise "Cannot land plane: weather stormy" if stormy?

    plane.land(self)
    add_plane(plane)
  end

  def take_off(plane)
    raise "Cannot take off plane: weather stormy" if stormy?
    raise "Cannot take off: plane not present" unless at_airport?(plane)

    plane.take_off
    remove_plane
    plane
  end

  private

  attr_reader :capacity, :weather_reporter

  def full?
    hangar.length >= capacity
  end

  def stormy?
    weather_reporter.stormy?
  end

  def at_airport?(plane)
    hangar.include?(plane)
  end

  def add_plane(plane)
    hangar << plane
  end

  def remove_plane
    hangar.pop
  end

end
