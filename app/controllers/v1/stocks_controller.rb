class V1::StocksController < ApplicationController
  def show
    render(json: { test: 'show' })
  end

  def create
    render(json: { test: 'create' })
  end

  def price
    render(json: { test: 'price' })
  end

  def market_price
    render(json: { test: 'market_price' })
  end
end
