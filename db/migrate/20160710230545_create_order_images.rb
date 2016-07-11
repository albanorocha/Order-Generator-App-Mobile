class CreateOrderImages < ActiveRecord::Migration
  def change
    create_table :order_images do |t|
      t.references :order, index: true, foreign_key: true
      t.string :mockup

      t.timestamps null: false
    end
  end
end
