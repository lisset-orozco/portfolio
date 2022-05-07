class V1::PortfoliosController < ApplicationController
  def index
    render(json: { test: 'index' })
  end

  def show
    render(json: { test: 'show' })
  end

  def create
    render(json: { test: 'create' })
  end

  def profit
    render(json: { test: 'profit' })
  end
end
