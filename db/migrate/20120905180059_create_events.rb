class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :colloquy_id
      t.string :name
      t.text :description
      t.string :location
      t.datetime :start
      t.datetime :stop

      t.timestamps
    end
  end
end
