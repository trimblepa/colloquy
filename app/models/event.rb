class Event < ActiveRecord::Base
  attr_accessible :colloquy_id, :description, :location, :name, :start, :stop

  belongs_to :colloquy
end
