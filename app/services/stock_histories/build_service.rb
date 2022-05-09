# frozen_string_literal: true

module StockHistories
  class BuildService < ApplicationService
    def initialize(params)
      super()
      @params = params
    end

    def call
      result = stock_histories(params[:histories], params[:portfolio_stock])
      response(success: true, payload: result)
    rescue StandardError
      response(error: StandardError.new(self))
    end

    private

    attr_reader :params

    def stock_histories(histories, portfolio_stock)
      histories.each_with_object([]) do |history, arr|
        arr << StockHistory.new(
          amount: history[:amount],
          price: history[:price],
          purchase_date: history[:purchase_date],
          portfolio_stock: portfolio_stock
        )
      end
    end
  end
end
