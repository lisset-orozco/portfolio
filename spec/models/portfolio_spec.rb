require 'rails_helper'

RSpec.describe(Portfolio, type: :model) do
  subject { build(:portfolio) }

  describe 'object' do
    it 'is valid' do
      expect(subject).to be_valid
    end

    it 'is not valid without name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end
  end

  describe 'relation' do
    it 'has_many portfolio_stocks' do
      t = described_class.reflect_on_association(:portfolio_stocks)
      expect(t.macro).to eq(:has_many)
    end
  end
end
