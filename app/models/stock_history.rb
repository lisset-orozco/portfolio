class StockHistory < ApplicationRecord
  validates_presence_of :amount, :price, :purchase_date
  validates_comparison_of :purchase_date, less_than_or_equal_to: Date.today

  belongs_to :portfolio_stock
end
