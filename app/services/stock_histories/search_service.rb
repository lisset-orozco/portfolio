# frozen_string_literal: true

module StockHistories
  class SearchService < ApplicationService
    def initialize(params)
      super()
      @params = params
    end

    def call
      stock = StockHistory.where(**params)
      response(success: true, payload: stock)
    rescue
      response(error: StandardError.new(self))
    end

    private

    attr_reader :params
  end
end
