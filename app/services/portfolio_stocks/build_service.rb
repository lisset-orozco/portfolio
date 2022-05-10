# frozen_string_literal: true

module PortfolioStocks
  class BuildService < ApplicationService
    def initialize(params)
      super()
      @params = params
    end

    def call
      portfolio_stock = PortfolioStock.new(portfolio: params[:portfolio], stock_id: params[:stock_id])
      response(success: true, payload: portfolio_stock)
    rescue
      response(error: StandardError.new(self))
    end

    private

    attr_reader :params
  end
end
