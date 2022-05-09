# frozen_string_literal: true

module Stocks
  class CreateUseCase < ApplicationUseCase
    def initialize(params)
      super()
      @params = params
    end

    def call
      search_portfolio
      search_stock_by_symbol
      build_portfolio_stocks_with_histories
      create_portfolio_with_portfolio_stocks
    rescue StandardError => e
      response(error: e)
    end

    private

    attr_reader :params, :portfolio, :stocks, :symbols, :stock_histories, :portfolio_stock, :portfolio_stocks

    def search_portfolio
      result = Portfolios::SearchService.call(id: params[:portfolio_id])
      raise result.error unless result.success?

      @portfolio = result.payload
    end

    def search_stock_by_symbol
      @symbols = params[:stocks].keys.each_with_object({}) do |symbol, hash| 
        result = Stocks::FindOrCreateService.call(symbol: symbol)
        raise result.error unless result.success?

        hash[symbol] = result.payload.id
      end
    end

    def build_portfolio_stock(stock_id)
      return if search_portfolio_stock(stock_id)

      result = PortfolioStocks::BuildService.call(portfolio:, stock_id:)
      raise result.error unless result.success?

      @portfolio_stock = result.payload
    end

    def search_portfolio_stock(stock_id)
      result = PortfolioStocks::SearchService.call(portfolio:, stock_id:)
      return unless result.success?

      @portfolio_stock = result.payload
    end


    def build_stock_histories(symbol, histories)
      result = StockHistories::BuildService.call(histories: histories, portfolio_stock:)
      raise result.error unless result.success?

      @stock_histories = result.payload
    end

    def build_portfolio_stocks_with_histories
      @portfolio_stocks = []
      params[:stocks].each do |symbol, histories|
        build_portfolio_stock(symbols[symbol])
        build_stock_histories(symbol, histories)
        
        @portfolio_stock.stock_histories << stock_histories

        @portfolio_stocks << portfolio_stock
      end
    end

    def create_portfolio_with_portfolio_stocks
      result = Portfolios::CreateService.call(portfolio:, portfolio_stocks:)
      raise result.error unless result.success?

      result
    end
  end
end
