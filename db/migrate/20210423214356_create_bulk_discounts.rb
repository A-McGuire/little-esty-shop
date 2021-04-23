class CreateBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.integer :threshold
      t.decimal :discount, precision: 5, scale: 2

      t.timestamps
    end
  end
end
