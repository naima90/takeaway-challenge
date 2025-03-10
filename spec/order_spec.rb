require 'order'
describe Order do
  subject(:order) { described_class.new(menu) }
  let(:menu) { double(:menu) }

  let(:dishes) do
    {
      fish: 1,
      chips: 2
    }
  end

  before do
    allow(menu).to receive(:availabe?).with(:fish).and_return(true)
    allow(menu).to receive(:availabe?).with(:chips).and_return(true)

    allow(menu).to receive(:price).with(:fish).and_return(4.40)
    allow(menu).to receive(:price).with(:chips).and_return(2.50)
  end

  it 'allows a number of dishes for selection' do
    order.add(:fish, 1)
    order.add(:chips, 2)
    expect(order.dishes).to eq(dishes)
  end

  it "doesn't alllow to select unavailabe dishes" do
    allow(menu).to receive(:availabe?).with(:rice).and_return(false)
    expect { order.add(:rice, 1) }.to raise_error "Rice is not availabe"
  end

  it "calculates the total of an order" do
    order.add(:fish, 1)
    order.add(:chips, 2)
    expect(order.total).to eq(9.40)
  end

end 