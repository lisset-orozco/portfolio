require 'rails_helper'

RSpec.describe Stock, type: :model do
  subject { build(:stock) }

  describe 'object' do
    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  describe '.validation' do
    context 'when symbol is not present' do
      before { subject.symbol = nil }
      it { expect(subject).to be_invalid }
    end

    context 'when symbol is not unique' do
      before { create(:stock, symbol: 'AXSUSDT') }
      it { expect(subject).to be_invalid }
    end

    context 'when symbol is unique' do
      before { create(:stock, symbol: 'ETHUSDT') }
      it { expect(subject).to be_valid }
    end
  end

  describe 'relation' do
    it 'has_many portfolio_stocks' do
      t = described_class.reflect_on_association(:portfolio_stocks)
      expect(t.macro).to eq(:has_many)
    end
  end
end
