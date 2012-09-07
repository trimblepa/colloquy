class Colloquy < ActiveRecord::Base
  attr_accessible :close, :description, :name, :open, :organization, :seats

  has_many :events
  has_many :categories
end
