# frozen_string_literal: true

module Portfolios
  class CreateUseCase < ApplicationUseCase
    def initialize(params)
      super()
      @params = params
    end

    def call
      create_stock_by_symbol
      build_portfolio
      build_portfolio_stocks_with_histories
      create_portfolio_with_portfolio_stocks
    rescue => error
      response(error:)
    end

    private

    attr_reader :params, :portfolio, :stocks, :symbols, :stock_histories, :portfolio_stock, :portfolio_stocks

    def build_portfolio
      result = Portfolios::BuildService.call(params)
      raise(result.error) unless result.success?

      @portfolio = result.payload
    end

    def create_stock_by_symbol
      @symbols =
        params[:stocks].keys.each_with_object({}) do |symbol, hash|
          result = Stocks::FindOrCreateService.call(symbol:)
          raise(result.error) unless result.success?

          hash[symbol] = result.payload.id
        end
    end

    def build_portfolio_stock(stock_id)
      result = PortfolioStocks::BuildService.call(portfolio:, stock_id:)
      raise(result.error) unless result.success?

      @portfolio_stock = result.payload
    end

    def build_stock_histories(_symbol, histories)
      result = StockHistories::BuildService.call(histories:, portfolio_stock:)
      raise(result.error) unless result.success?

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
      raise(result.error) unless result.success?

      result
    end
  end
end
