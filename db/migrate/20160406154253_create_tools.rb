class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.text :name
      t.decimal :price, precision: 20, scale: 2
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
