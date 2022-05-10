require 'swagger_helper'

RSpec.describe 'v1/portfolios', type: :request do

  path '/v1/portfolios/{id}/profit?start_date={start_date}&end_date={end_date}', vcr: { record: :none } do
    parameter name: 'id', in: :path, type: :string, description: 'portfolio_id', example: 1
    parameter name: 'start_date', in: :path, type: :string, description: 'start_date', example: '2022-04-03'
    parameter name: 'end_date', in: :path, type: :string, description: 'end_date', example: '2022-05-10'

    get('profit portfolio') do
      tags 'Portfolios'
      description 'Returns the profit of the Portfolio between two dates'
      produces 'application/json'

      response(200, 'successful') do
        let(:id) do
          portfolio_stock = create(:portfolio_stock)
          create(:stock_history, portfolio_stock:)
          portfolio_stock.portfolio.id
        end
        let(:start_date) { '2022-04-03' }
        let(:end_date) { '2022-05-10' }

        schema type: :object,
          properties: {
            profit_by_stock: { type: :object, example: { 'AXSUSDT' => '91.5'} },
            annualized_profit: { type: :string, example: '1098' }
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

  path '/v1/portfolios' do
    post('create portfolio') do
      tags 'Portfolios'
      description 'Request the creation of a portfolio with stocks'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :portfolio, in: :body, schema: { '$ref' => '#/components/schemas/portfolio' }

      response(200, 'successful') do
        let(:portfolio) { build(:portfolio_payload) }

        schema type: :object,
          properties: {
            id: { type: :integer, example: 3 }
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
