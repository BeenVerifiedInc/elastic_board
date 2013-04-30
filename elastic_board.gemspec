# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elastic_board/version'

Gem::Specification.new do |gem|
  gem.name          = "elastic_board"
  gem.version       = ElasticBoard::VERSION
  gem.authors       = ["Patrick Tulskie"]
  gem.email         = ["patricktulskie@gmail.com"]
  gem.description   = %q{Status board rack middleware for ElasticSearch}
  gem.summary       = %q{Simple ElasticSearch status board middleware for rack applictions}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency("sinatra")
  gem.add_dependency("rubberband")
  
  gem.add_development_dependency("shotgun")
end
