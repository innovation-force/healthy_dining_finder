$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "healthy_dining_finder/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "healthy_dining_finder"
  s.version     = HealthyDiningFinder::VERSION
  s.authors     = ["Wilfrid Joseph Landry"]
  s.email       = ["joe.landry@cambiahealth.com"]
  s.homepage    = "https://gitlab.cambiatools.com/basefit/healthy_dining_finder"
  s.summary     = "Library for interfacing with the Healthy Dining Finder API."
  s.description = " Description of HealthyDiningFinder."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
end
