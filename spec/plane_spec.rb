require 'plane'

describe Plane do

  subject(:plane) { described_class.new }
  let(:airport) { double :airport }

  describe '#take_off' do

    it { is_expected.to respond_to :take_off }

    context 'when inflight' do
      it 'raises an error' do
        expect { plane.take_off }.to raise_error "Plane already inflight"
      end
    end

  end

  describe '#land' do

    it 'stores the airport the plane landed at' do
      plane.land(airport)
      expect(plane.airport).to eq airport
    end

    context 'when already landed' do
      it 'raises an error' do
        plane.land(airport)
        expect { plane.land(airport) }.to raise_error "Plane has already landed"
      end
    end

  end

  describe '#airport' do

    it { is_expected.to respond_to :airport }

    it 'raises an error if already inflight' do
      expect { plane.airport }.to raise_error "Plane is inflight"
    end

  end

end
