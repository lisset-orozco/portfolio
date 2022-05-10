# frozen_string_literal: true

class StockHistoryQuery < ApplicationQuery
  def call(params)
    @scope = histories(params)
    scope
  end

  private

  attr_reader :scope

  def histories(params)
    scope.where(
      portfolio_stock: params[:portfolio_stock],
      purchase_date: params[:start_date]..params[:end_date]
    )
  end
end
