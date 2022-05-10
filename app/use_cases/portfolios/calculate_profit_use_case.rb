# frozen_string_literal: true

module Portfolios
  class CalculateProfitUseCase < ApplicationUseCase
    def initialize(params)
      super()
      @params = params
    end

    def call
      search_portfolio
      search_stock_histores
      calculate_amount_and_price_by_stock

      response(success: true, payload: calculate_profit)
    rescue => error
      response(error: [StandardError.new(self), error])
    end

    private

    attr_reader :params, :portfolio, :portfolio_stocks, :histories_by_stock, :stock_details

    def search_portfolio
      @portfolio = PortfolioQuery.new.call(id: params[:id])
    end

    def search_stock_histores
      @histories_by_stock =
        portfolio.portfolio_stocks.each_with_object({}) do |portfolio_stock, hash|
          hash[portfolio_stock.stock.symbol] = StockHistoryQuery.new.call(
            portfolio_stock:,
            purchase_date: params[:start_date]..params[:end_date]
          )
        end
    end

    def calculate_amount_and_price_by_stock
      @stock_details =
        histories_by_stock.each_with_object({}) do |(symbol, histories), hash|
          hash[symbol] = { total_stock: histories.map(&:amount).sum, total_invested: histories.map(&:price).sum }
        end
    end

    def search_end_date_price(symbol, end_date)
      result = Stocks::MarketPriceService.call(symbol:, date: end_date)
      raise(result.error) unless result.success?

      result.payload
    end

    def calculate_profit
      days = Date.parse(params[:end_date]).mjd - Date.parse(params[:start_date]).mjd
      profit_by_stock = {}
      total_profit = 0

      stock_details.each do |symbol, values|
        end_date_price = search_end_date_price(symbol, params[:end_date])
        current_profit = values[:total_stock] * end_date_price.to_d
        profit = [(current_profit - values[:total_invested]), 0].max
        profit_by_stock[symbol] = format('%.2f', profit)
        total_profit += profit
      end

      {
        profit_by_stock:,
        annualized_profit: format('%.2f', ((total_profit / days) * 365))
      }
    end
  end
end
