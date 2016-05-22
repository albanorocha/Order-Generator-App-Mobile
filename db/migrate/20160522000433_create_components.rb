class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.references :block, index: true, foreign_key: true
      t.string :title
      t.string :head
      t.text :description
      t.text :footer
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps null: false
    end
  end
end
