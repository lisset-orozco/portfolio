class V1::PortfoliosController < ApplicationController
  def create
    result = Portfolios::CreateUseCase.call(portfolio_params)

    if result.success?
      render json: { id: result.payload.id }
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end

  def profit
    result = Portfolios::CalculateProfitUseCase.call(portfolio_params)

    if result.success?
      render json: result.payload
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end

  private
  
  def portfolio_params
    params.permit(:id, :name, :description, :start_date, :end_date, stocks: {})
  end
end
