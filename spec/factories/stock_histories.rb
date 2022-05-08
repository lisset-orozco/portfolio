FactoryBot.define do
  factory :stock_history do
    amount { 1.5 }
    price { 1.5 }
    purchase_date { '2022-05-08' }
    portfolio_stock
  end
end
