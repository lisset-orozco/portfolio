class CreateStockHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_histories do |t|
      t.float :amount, null: false
      t.float :price, null: false
      t.datetime :purchase_date, null: false
      t.references :portfolio_stock, null: false, foreign_key: true

      t.timestamps
    end
  end
end
