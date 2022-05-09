# frozen_string_literal: true

module Stocks
  class SearchService < ApplicationService
    def initialize(params)
      super()
      @params = params
    end

    def call
      stock = Stock.find_by!(**params)
      response(success: true, payload: stock)
    rescue StandardError
      response(error: StandardError.new(self))
    end

    private

    attr_reader :params
  end
end
