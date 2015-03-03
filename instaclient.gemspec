$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "instaclient/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "instaclient"
  s.version     = Instaclient::VERSION
  s.authors     = ["Tiago Scolari"]
  s.email       = ["tscolari@gmail.com"]
  s.homepage    = "https://github.com/tscolari/instaclient"
  s.summary     = "Simple instagram client"
  s.description = "Read-only instagran client"

  s.files = Dir["{config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "typhoeus"

  s.add_development_dependency "rspec"
  s.add_development_dependency "pry"
  s.add_development_dependency "pry-nav"
  s.add_development_dependency "webmock"
end
