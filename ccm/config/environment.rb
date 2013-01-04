# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Ccm::Application.initialize!

ENV['TZ'] = 'Eastern Time (US & Canada)'
