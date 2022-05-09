class V1::StocksController < ApplicationController
  def show
    render(json: { test: 'show' })
  end

  def create
    result = Stocks::CreateUseCase.call(params)

    if result.success?
      render json: { id: result.payload.id }
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end

  def price
    result = Stocks::FindPriceUseCase.call(params)

    if result.success?
      render json: StockHistorySerializer.new(result.payload), status: :ok
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end

  def market_price
    render(json: { test: 'market_price' })
  end
end
