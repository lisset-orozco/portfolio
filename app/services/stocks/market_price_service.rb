# frozen_string_literal: true

module Stocks
  class MarketPriceService < ApplicationService
    def initialize(params)
      super()
      @params = params
    end

    def call
      response = HttpClientUtil.call('get', build_params)
      result = handle_response(response)

      response(success: true, payload: result)
    rescue
      response(error: StandardError.new(self))
    end

    private

    attr_reader :params

    def build_params
      url = 'https://api.binance.com/api/v3/klines'
      uri = URI(url)
      uri.query = URI.encode_www_form(query_params)
      { url: uri }
    end

    def handle_response(response)
      raise unless (200..299).include?(response.code)

      result = JSON.parse(response.body)
      result.present? ? format('%.2f', result[0][4]) : ''
    end

    def query_params
      miliseconds = (params[:date].to_time.to_f * 1000).to_i
      {
        symbol: params[:symbol],
        interval: '1d',
        startTime: miliseconds,
        endTime: miliseconds
      }
    end
  end
end
