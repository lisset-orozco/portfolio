class PortfolioStock < ApplicationRecord
  validates_uniqueness_of :portfolio_id, :stock_id
  validates_presence_of :portfolio_id, :stock_id

  belongs_to :portfolio
  belongs_to :stock
end
