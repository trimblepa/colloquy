# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Rhizhome::Application.initialize!
# warning !!!!!
Tilt::CoffeeScriptTemplate.default_bare = true
