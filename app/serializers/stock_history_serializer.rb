class StockHistorySerializer
  include JSONAPI::Serializer
  attributes :amount, :price

  attribute :purchase_date do |object|
    object.purchase_date.strftime('%F')
  end
end
