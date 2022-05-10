# frozen_string_literal: true

module Portfolios
  class SearchService < ApplicationService
    def initialize(params)
      super()
      @params = params
    end

    def call
      portfolio = Portfolio.find_by!(**params)
      response(success: true, payload: portfolio)
    rescue
      response(error: StandardError.new(self))
    end

    private

    attr_reader :params
  end
end
