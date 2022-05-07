class CreatePortfolios < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolios do |t|
      t.string :name, null: false
      t.string :description

      t.timestamps
    end
  end
end
