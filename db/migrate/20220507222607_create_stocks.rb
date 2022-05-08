class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :symbol, null: false, index: true, unique: true

      t.timestamps
    end
  end
end
