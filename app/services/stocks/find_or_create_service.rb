# frozen_string_literal: true

module Stocks
  class FindOrCreateService < ApplicationService
    def initialize(params)
      super()
      @params = params
    end

    def call
      response(success: true, payload: find_or_create(params[:symbol]))
    rescue
      response(error: StandardError.new(self))
    end

    private

    attr_reader :params

    def find_or_create(symbol)
      Stock.transaction(requires_new: true) do
        Stock.find_or_create_by(symbol:)
      end
    rescue ActiveRecord::RecordNotUnique
      retry
    end
  end
end
