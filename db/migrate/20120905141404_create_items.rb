class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :location
      t.string :date

      t.timestamps
    end
  end
end
