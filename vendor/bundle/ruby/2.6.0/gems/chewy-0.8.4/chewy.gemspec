# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chewy/version'

Gem::Specification.new do |spec|
  spec.name          = 'chewy'
  spec.version       = Chewy::VERSION
  spec.authors       = ['pyromaniac']
  spec.email         = ['kinwizard@gmail.com']
  spec.summary       = 'Elasticsearch ODM client wrapper'
  spec.description   = 'Chewy provides functionality for Elasticsearch index handling, documents import mappings and chainable query DSL'
  spec.homepage      = 'https://github.com/toptal/chewy'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($RS)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'rspec', '~> 3.4.0'
  spec.add_development_dependency 'rspec-its'
  spec.add_development_dependency 'rspec-collection_matchers'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'elasticsearch-extensions'
  spec.add_development_dependency 'resque_spec'
  spec.add_development_dependency 'rubysl', '~> 2.0' if RUBY_ENGINE == 'rbx'

  spec.add_development_dependency 'method_source'
  if RUBY_VERSION < '2.1.0'
    spec.add_development_dependency 'unparser', '0.2.4'
  else
    spec.add_development_dependency 'unparser'
  end

  spec.add_dependency 'activesupport', '>= 3.2'
  spec.add_dependency 'elasticsearch', '>= 1.0.0'
end