require 'httparty'

%w(client pet shelter).each do |file|
  require File.join(File.dirname(__FILE__), 'pet_finder', file)
end