class PortfolioStock < ApplicationRecord
  validates :portfolio_id, uniqueness: { scope: :stock_id } 

  belongs_to :portfolio
  belongs_to :stock
  has_many :stock_histories
end
