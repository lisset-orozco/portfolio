# frozen_string_literal: true

class PortfolioQuery < ApplicationQuery
  def call(params)
    @scope = search_with_stocks(params)
    scope
  end

  private

  attr_reader :scope

  def search_with_stocks(params)
    scope.includes(:stocks).find_by!(**params)
  end
end
