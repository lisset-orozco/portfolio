class V1::PortfoliosController < ApplicationController
  def create
    result = Portfolios::CreateUseCase.call(params)

    if result.success?
      render json: { id: result.payload.id }
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end

  def profit
    render(json: { test: 'profit' })
  end
end
