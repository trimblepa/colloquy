class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :colloquy_id
      t.string :name
      t.text :description
      t.string :price

      t.timestamps
    end
  end
end
