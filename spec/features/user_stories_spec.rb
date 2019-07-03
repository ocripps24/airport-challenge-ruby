describe 'User Stories' do

  let(:airport) { Airport.new(20, weather_reporter) }
  let(:plane) { Plane.new }
  let(:weather_reporter) { WeatherReporter.new }

  context 'when not stormy' do

    before do
      allow(weather_reporter).to receive(:stormy?) { false }
    end

    # As an air traffic controller
    # So I can get passengers to a destination
    # I want to instruct a plane to land at an airport
    it 'so planes land at airports, instruct a plane to land' do
      expect { airport.land(plane) }.not_to raise_error
    end

    # As an air traffic controller
    # So I can get passengers on the way to their destination
    # I want to instruct a plane to take off from an airport
    it 'so planes take off, instruct a plane to take off' do
      expect { airport.take_off(plane) }.not_to raise_error
    end

  end

  # As an air traffic controller
  # To ensure safety
  # I want to prevent landing when the airport is full
  context 'when airport is full' do
    it 'prevents plane landing' do
      allow(weather_reporter).to receive(:stormy?) { false }
      20.times do
        airport.land(plane)
      end
      expect { airport.land(plane) }.to raise_error "Cannot land plane: airport full"
    end
  end

  context 'when weather is stormy' do

    before do
      allow(weather_reporter).to receive(:stormy?) { true }
    end

    # As an air traffic controller
    # To ensure safety
    # I want to prevent landing when weather is stormy
    it 'prevents planes landing' do
      expect { airport.land(plane) }.to raise_error "Cannot land plane: weather stormy"
    end

    # As an air traffic controller
    # To ensure safety
    # I want to prevent takeoff when weather is stormy
    it 'prevents planes taking off' do
      expect { airport.take_off(plane) }.to raise_error "Cannot take off plane: weather stormy"
    end
  end

end

# As an air traffic controller
# So I can get passengers on the way to their destination
# I want to instruct a plane to take off from an airport and confirm that it is no longer in the airport

# As the system designer
# So that the software can be used for many different airports
# I would like a default airport capacity that can be overridden as appropriate
