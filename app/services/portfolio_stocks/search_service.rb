# frozen_string_literal: true

module PortfolioStocks
  class SearchService < ApplicationService
    def initialize(params)
      super()
      @params = params
    end

    def call
      portfolio_stock = PortfolioStock.find_by!(**params)
      response(success: true, payload: portfolio_stock)
    rescue
      response(error: StandardError.new(self))
    end

    private

    attr_reader :params
  end
end
