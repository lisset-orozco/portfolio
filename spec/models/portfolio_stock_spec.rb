require 'rails_helper'

RSpec.describe PortfolioStock, type: :model do
  let(:stock) { create(:stock, symbol: 'ETHUSDT') }
  let(:portfolio) { create(:portfolio) }

  subject { build(:portfolio_stock, portfolio: portfolio, stock: stock) }

  describe 'object' do
    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  describe 'relation' do
    it 'belongs_to portfolio' do
      t = described_class.reflect_on_association(:portfolio)
      expect(t.macro).to eq(:belongs_to)
    end

    it 'belongs_to stock' do
      t = described_class.reflect_on_association(:stock)
      expect(t.macro).to eq(:belongs_to)
    end

    it 'has_many stock_histories' do
      t = described_class.reflect_on_association(:stock_histories)
      expect(t.macro).to eq(:has_many)
    end
  end

  describe '.validation' do
    context 'when combined portfolio_id and stock_id are not unique' do
      before { create(:portfolio_stock, portfolio: portfolio, stock: stock) }
      it { expect(subject).to be_invalid }
    end
  end
end
