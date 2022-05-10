class Portfolio < ApplicationRecord
  validates_presence_of :name

  has_many :portfolio_stocks
  has_many :stocks, through: :portfolio_stocks
end
