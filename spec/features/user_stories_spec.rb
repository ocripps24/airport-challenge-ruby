describe 'User Stories' do

  let(:airport) { Airport.new(weather_reporter, 20) }
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
      airport.land(plane)
      expect { airport.take_off(plane) }.not_to raise_error
    end

    # As an air traffic controller
    # To easily monitor planes
    # I want planes only to take off from the airport they are at
    it 'takes off planes only from their current airport' do
      airport_2 = Airport.new(weather_reporter, 20)
      airport_2.land(plane)
      expect { airport.take_off(plane) }.to raise_error "Cannot take off: plane not present"
    end

    # As the system designer
    # So that the software can be used for many different airports
    # I would like a default airport capacity that can be overridden as appropriate
    it 'airports have a default capacity' do
      default_airport = Airport.new(weather_reporter)
      Airport::DEFAULT_CAPACITY.times do
        the_plane = Plane.new
        default_airport.land(the_plane)
      end
      expect { default_airport.land(plane) }.to raise_error "Cannot land plane: airport full"
    end

    # As an air traffic controller
    # To ensure safety
    # I want to ensure a flying plane cannot take off or be in the airport
    it 'flying planes cannot take off' do
      expect { plane.take_off }.to raise_error "Plane already inflight"
    end

    it 'flying planes cannot be in an airport' do
      expect { plane.airport }.to raise_error "Plane is inflight"
    end

    # As an air traffic controller
    # To ensure safety
    # I want to ensure a landed plane cannot land and must be in a the airport
    it 'non-flying planes cannot land' do
      airport.land(plane)
      expect { plane.land(airport) }.to raise_error "Plane has already landed"
    end

    it 'non-flying planes must be in an airport' do
      airport.land(plane)
      expect(plane.airport).to eq airport
    end

    # As an air traffic controller
    # So I can get passengers on the way to their destination
    # I want to ensure a taken off plane is no longer in the airport
    it 'taking off a plane removes it from that airport' do
      airport.land(plane)
      airport.take_off(plane)
      expect(airport.hangar).not_to include plane 
    end

    # As an air traffic controller
    # To ensure safety
    # I want to prevent landing when the airport is full
    context 'when airport is full' do
      it 'prevents plane landing' do
        allow(weather_reporter).to receive(:stormy?) { false }
        20.times do
          the_plane = Plane.new
          airport.land(the_plane)
        end
        expect { airport.land(plane) }.to raise_error "Cannot land plane: airport full"
      end
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
