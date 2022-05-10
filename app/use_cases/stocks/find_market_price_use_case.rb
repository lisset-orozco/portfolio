# frozen_string_literal: true

module Stocks
  class FindMarketPriceUseCase < ApplicationUseCase
    def initialize(params)
      super()
      @params = params
    end

    def call
      search_market_price
    rescue => error
      response(error:)
    end

    private

    attr_reader :params

    def search_market_price
      Stocks::MarketPriceService.call(params)
    end
  end
end
