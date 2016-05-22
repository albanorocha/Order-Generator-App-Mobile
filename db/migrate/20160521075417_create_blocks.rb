class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.references :order, index: true, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
