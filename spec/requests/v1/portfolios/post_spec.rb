# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('V1::Portfolios', type: :request) do
  describe 'POST /v1/portfolios' do
    context 'success' do
      it 'returns http ok' do
        expect do
          params = build(:portfolio_payload)
          request(:post, '/v1/portfolios', params)

          expect(status).to eq(200)
          expect(response).to have_http_status(:ok)
          expect(json_body).to include('id' => a_kind_of(Integer))
        end.to change { Portfolio.count }
          .by(1)
      end
    end

    context 'fails' do
      it 'returns an error due to missing params' do
        request(:post, '/v1/portfolios')

        expect(status).to eq(422)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
