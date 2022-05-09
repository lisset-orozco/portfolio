# frozen_string_literal: true

module Portfolios
  class CreateService < ApplicationService
    def initialize(params)
      super()
      @params = params
    end

    def call
      portfolio = params[:portfolio]
      portfolio.portfolio_stocks << params[:portfolio_stocks]
      portfolio.save!

      response(success: true, payload: portfolio)
    rescue StandardError
      response(error: StandardError.new(self))
    end

    private

    attr_reader :params
  end
end
