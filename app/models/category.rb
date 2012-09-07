class Category < ActiveRecord::Base
  attr_accessible :colloquy_id, :description, :name, :price

  belongs_to :colloquy
end
