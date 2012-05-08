Gem::Specification.new do |s|
  s.name        = "petfinder_client"
  s.version     = 0.1
  s.author      = "Ben Wanicur"
  s.email       = "bwanicur@gmail.com"
  s.homepage    = "http://github.com/bwanicur/petfinder_client"
  s.summary     = "Wrapper for Petfinder API"
  s.description = "Wrapper for Petfinder API"
  
  s.files        = Dir["{lib,spec}/**/*"]
  s.require_path = "lib"
  
  s.rubyforge_project = s.name
  s.required_rubygems_version = ">= 1.3.4"
  
  s.add_dependency("httparty", ["~> 0.8.1"])
  s.add_dependency("vcr", ["~> 2.1.1"])
  s.add_dependency("activesupport", ["~> 3.2"])
end