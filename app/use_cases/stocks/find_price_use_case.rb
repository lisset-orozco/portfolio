# frozen_string_literal: true

module Stocks
  class FindPriceUseCase < ApplicationUseCase
    def initialize(params)
      super()
      @params = params
    end

    def call
      search_portfolio
      search_stock
      search_portfolio_stock
      search_stock_histories
    rescue => error
      response(error:)
    end

    private

    attr_reader :params, :portfolio, :stock, :portfolio_stock, :stock_histories

    def search_portfolio
      result = Portfolios::SearchService.call(id: params[:portfolio_id])
      raise(result.error) unless result.success?

      @portfolio = result.payload
    end

    def search_stock
      result = Stocks::SearchService.call(symbol: params[:symbol])
      raise(result.error) unless result.success?

      @stock = result.payload
    end

    def search_portfolio_stock
      result = PortfolioStocks::SearchService.call(portfolio:, stock:)
      raise(result.error) unless result.success?

      @portfolio_stock = result.payload
    end

    def search_stock_histories
      result = StockHistories::SearchService.call(portfolio_stock:, purchase_date: params[:date])
      raise(result.error) unless result.success?

      result
    end
  end
end
