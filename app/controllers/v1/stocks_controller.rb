# frozen_string_literal: true

module V1
  class StocksController < ApplicationController
    def create
      result = Stocks::CreateUseCase.call(params)

      if result.success?
        render(json: { id: result.payload.id })
      else
        render(json: { error: result.error }, status: :unprocessable_entity)
      end
    end

    def price
      result = Stocks::FindPriceUseCase.call(params)

      if result.success?
        render(json: StockHistorySerializer.new(result.payload), status: :ok)
      else
        render(json: { error: result.error }, status: :unprocessable_entity)
      end
    end

    def market_price
      result = Stocks::FindMarketPriceUseCase.call(params)

      if result.success?
        render(json: { market_price: result.payload })
      else
        render(json: { error: result.error }, status: :unprocessable_entity)
      end
    end

    private

    def stock_params
      params.permit(:portfolio_id, :date, :symbol, stocks: {})
    end
  end
end
