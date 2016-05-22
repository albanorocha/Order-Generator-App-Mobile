class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.string :code
      t.boolean :enable
      t.date :starting_at
      t.date :ending_at
      t.integer :order_type

      t.timestamps null: false
    end
  end
end
