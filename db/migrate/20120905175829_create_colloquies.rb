class CreateColloquies < ActiveRecord::Migration
  def change
    create_table :colloquies do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.string :organization
      t.integer :seats
      t.datetime :open
      t.datetime :close

      t.timestamps
    end
  end
end
