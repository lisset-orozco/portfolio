# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('V1::Stocks', type: :request) do
  describe 'GET /v1/stocks/:symbol/price?date=?', vcr: { record: :none } do
    context 'when the request is successful' do
      it 'returns a price from market' do
        symbol = 'BTCUSDT'
        date = '2022-05-08'
        request(:get, "/v1/stocks/#{symbol}/price?date=#{date}")

        expect(status).to eq(200)
        expect(response).to have_http_status(:ok)
        expect(json_body).to include('market_price' => '34038.40')
      end
    end

    context 'when the request fails' do
      it 'returns an error due to invalid symbol' do
        symbol = 'TESTUSDT'
        date = '2022-05-08'
        request(:get, "/v1/stocks/#{symbol}/price?date=#{date}")

        expect(status).to eq(422)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
