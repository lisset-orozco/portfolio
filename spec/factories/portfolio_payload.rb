FactoryBot.define do
  factory :portfolio_payload, class: Hash do
    initialize_with do
      {
        name: 'personal',
        description: 'finanza personal',
        stocks: {
          ROSEUSDT: [
            {
              amount: 1.5,
              purchase_date: '2022-04-29',
              price: 36.5
            },
            {
              amount: 5,
              purchase_date: '2022-04-30',
              price: 34.3
            }
          ],
          SLPUSDT: [
            {
              amount: 600,
              purchase_date: '2022-04-29',
              price: 0.09
            },
            {
              amount: 300,
              purchase_date: '2022-04-30',
              price: 0.08
            }
          ],
          ETHUSDT: [
            {
              amount: 1,
              purchase_date: '2022-04-29',
              price: 2549
            }
          ]
        }
      }
    end
  end
end
