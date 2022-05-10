# frozen_string_literal: true

class StockHistory < ApplicationRecord
  validates :amount, :price, :purchase_date, presence: true
  validates_comparison_of :purchase_date, less_than_or_equal_to: Time.zone.today

  belongs_to :portfolio_stock
end
