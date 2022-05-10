# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('V1::Stocks', type: :request) do
  describe 'GET /v1/portfolios/:portfolio_id/stocks/:symbol/price?date=?' do
    context 'when the request is successful' do
      let(:portfolio) do
        portfolio_stock = create(:portfolio_stock)
        create(:stock_history, portfolio_stock:, purchase_date: '2022-05-08', price: 37.5, amount: 1.5)
        portfolio_stock.portfolio
      end

      it 'returns the price from records' do
        symbol = portfolio.portfolio_stocks[0].stock.symbol
        id = portfolio.id
        date = '2022-05-08'
        request(:get, "/v1/portfolios/#{id}/stocks/#{symbol}/price?date=#{date}")

        expect(status).to eq(200)
        expect(response).to have_http_status(:ok)
        expect(json_body).to include(
          'data' => [
            {
              'id' => a_kind_of(String),
              'type' => 'stock_history',
              'attributes' => {
                'amount' => 1.5,
                'price' => 37.5,
                'purchase_date' => '2022-05-08'
              }
            }
          ]
        )
      end
    end

    context 'when the request fails' do
      let(:portfolio) { create(:portfolio) }

      it 'returns an error due to invalid symbol' do
        symbol = 'TESTUSDT'
        date = '2022-05-08'
        request(:get, "/v1/portfolios/#{portfolio.id}/stocks/#{symbol}/price?date=#{date}")

        expect(status).to eq(422)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
