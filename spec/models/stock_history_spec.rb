require 'rails_helper'

RSpec.describe StockHistory, type: :model do
  subject { build(:stock_history) }

  describe 'relation' do
    it 'belongs_to stock' do
      t = described_class.reflect_on_association(:portfolio_stock)
      expect(t.macro).to eq(:belongs_to)
    end
  end

  describe 'object' do
    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  describe '.validation' do
    context 'when amount is not present' do
      before { subject.amount = nil }
      it { expect(subject).to be_invalid }
    end

    context 'when price is not present' do
      before { subject.price = nil }
      it { expect(subject).to be_invalid }
    end

    context 'when purchase_date is not present' do
      before { subject.purchase_date = nil }
      it { expect(subject).to be_invalid }
    end

    context 'when purchase_date is greater than today' do
      before { subject.purchase_date = Date.today + 10 }
      it { expect(subject).to be_invalid }
    end

    context 'when purchase_date is incorrect' do
      before { subject.purchase_date = '2022-22-31' }
      it { expect(subject).to be_invalid }
    end
  end
end
