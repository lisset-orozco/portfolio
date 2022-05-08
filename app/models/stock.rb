class Stock < ApplicationRecord
  validates :symbol, presence: true, uniqueness: true

  has_many :portfolio_stocks
end
