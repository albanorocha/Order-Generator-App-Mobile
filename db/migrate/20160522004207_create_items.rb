class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :component, index: true, foreign_key: true
      t.string :title
      t.string :subtitle
      t.text :description
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps null: false
    end
  end
end
