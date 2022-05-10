require 'rails_helper'

RSpec.describe 'V1::Portfolios', type: :request do
  describe 'POST /v1/portfolios' do
    context 'success' do
      it 'returns http ok' do
        expect {
          params = build(:portfolio_payload)
          request(:post, '/v1/portfolios', params)

          expect(status).to eq(200)
          expect(response).to have_http_status(:ok)
          expect(json_body).to include('id' => a_kind_of(Integer))
        }.to change { Portfolio.count }.by(1)
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

  describe 'GET /v1/portfolios/:id/profit?start_date=?&end_date=?' do
    context 'success' do
      let(:portfolio) do
        portfolio_stock = create(:portfolio_stock)
        create(:stock_history, portfolio_stock: portfolio_stock)
        portfolio_stock.portfolio
      end

      it 'returns a profit', vcr: { record: :none } do
        request(:get, "/v1/portfolios/#{portfolio.id}/profit?start_date=2022-04-09&end_date=2022-05-09")

        expect(status).to eq(200)
        expect(response).to have_http_status(:ok)
        expect(json_body).to include(
          'annualized_profit' => a_kind_of(String),
          'profit_by_stock' => { 'AXSUSDT' => a_kind_of(String) }
        )
      end
    end

    context 'fails' do
      it 'returns an error due to invalid id' do
        request(:get, "/v1/portfolios/6/profit?start_date=2022-04-09&end_date=2022-05-09")

        expect(status).to eq(422)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
