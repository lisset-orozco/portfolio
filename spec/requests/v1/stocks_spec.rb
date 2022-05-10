require 'swagger_helper'

RSpec.describe 'v1/stocks', type: :request do

  path '/v1/portfolios/{portfolio_id}/stocks' do
    parameter name: 'portfolio_id', in: :path, type: :string, description: 'portfolio_id', example: 1

    post('create stock') do
      tags 'Stocks'
      description 'Add more stocks to an existing portfolio'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :stocks, in: :body, schema: {
        type: :object,
        properties: {
          stocks: { '$ref' => '#/components/schemas/portfolio/properties/stocks' }
        }
      }

      response(200, 'successful') do
        let(:portfolio_id) { create(:portfolio).id }
        let(:stocks) { build(:stocks_payload) }

        schema type: :object,
          properties: {
            id: { type: :integer, example: 1 }
          }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/v1/portfolios/{portfolio_id}/stocks/{symbol}/price?date={date}' do
    parameter name: 'portfolio_id', in: :path, type: :string, description: 'portfolio_id', example: 1
    parameter name: 'symbol', in: :path, type: :string, description: 'stock symbol', example: 'BTCUSDT'
    parameter name: 'date', in: :path, type: :string, description: 'date', example: '2022-04-30'

    get('price stock') do
      tags 'Stocks'
      description 'Show the record of a stock purchased on a given date'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        let(:portfolio_id) do
          portfolio_stock = create(:portfolio_stock)
          create(:stock_history, portfolio_stock:)
          portfolio_stock.portfolio.id
        end
        let(:symbol) { 'AXSUSDT' }
        let(:date) { '2022-04-30' }

        schema type: :object,
          properties: {
            data: {
              type: :array,
              items: {
                type: 'object',
                properties: {
                  id: { type: 'string', example: 3 },
                  type: { type: 'string', example: 'stock_history' }, 
                  attributes: {
                    type: 'object',
                    properties: {
                      amount: { type: 'number', example: 1.5 },
                      price: { type: 'number', example: 1.5 },
                      purchase_date: { type: 'string', example: '2022-04-30' }
                    }
                  }
                }
              }
            }
          }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/v1/stocks/{symbol}/price?date={date}', vcr: { record: :none } do
    parameter name: 'symbol', in: :path, type: :string, description: 'stock symbol', example: 'BTCUSDT'
    parameter name: 'date', in: :path, type: :string, description: 'date', example: '2022-04-30'

    get('market_price stock') do
      tags 'Stocks'
      description 'Show the market price of a stock on a given date'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        let(:symbol) { 'BTCUSDT' }
        let(:date) { '2022-04-30' }

        schema type: :object,
          properties: {
            market_price: { type: :string, example: '32576.45' }
          }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
