# frozen_string_literal: true

module Portfolios
  class BuildService < ApplicationService
    def initialize(params)
      super()
      @params = params
    end

    def call
      portfolio = Portfolio.new(name: params[:name], description: params[:description])
      response(success: true, payload: portfolio)
    rescue
      response(error: StandardError.new(self))
    end

    private

    attr_reader :params
  end
end
