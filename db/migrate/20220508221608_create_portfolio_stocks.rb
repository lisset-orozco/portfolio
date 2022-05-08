class CreatePortfolioStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolio_stocks do |t|
      t.references :portfolio, null: false, foreign_key: true
      t.references :stock, null: false, foreign_key: true

      t.timestamps
    end
    add_index :portfolio_stocks, [:portfolio_id, :stock_id], unique: true
  end
end
