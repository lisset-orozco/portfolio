# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('V1::Stocks', type: :request) do
  describe 'POST /v1/portfolios/:portfolio_id/stocks' do
    let(:portfolio) { create(:portfolio) }

    context 'when the request is successful' do
      it 'returns http ok' do
        expect do
          params = build(:stocks_payload)
          request(:post, "/v1/portfolios/#{portfolio.id}/stocks", params)

          expect(status).to eq(200)
          expect(response).to have_http_status(:ok)
          expect(json_body).to include('id' => a_kind_of(Integer))
        end.to change { StockHistory.count }
          .by(5)
      end
    end

    context 'when the request fails' do
      it 'returns an error due to missing params' do
        request(:post, "/v1/portfolios/#{portfolio.id}/stocks", {})

        expect(status).to eq(422)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
