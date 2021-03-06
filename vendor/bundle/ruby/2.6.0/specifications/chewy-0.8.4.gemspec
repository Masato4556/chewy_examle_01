# -*- encoding: utf-8 -*-
# stub: chewy 0.8.4 ruby lib

Gem::Specification.new do |s|
  s.name = "chewy".freeze
  s.version = "0.8.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["pyromaniac".freeze]
  s.date = "2016-03-20"
  s.description = "Chewy provides functionality for Elasticsearch index handling, documents import mappings and chainable query DSL".freeze
  s.email = ["kinwizard@gmail.com".freeze]
  s.homepage = "https://github.com/toptal/chewy".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Elasticsearch ODM client wrapper".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.4.0"])
      s.add_development_dependency(%q<rspec-its>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec-collection_matchers>.freeze, [">= 0"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_development_dependency(%q<database_cleaner>.freeze, [">= 0"])
      s.add_development_dependency(%q<elasticsearch-extensions>.freeze, [">= 0"])
      s.add_development_dependency(%q<resque_spec>.freeze, [">= 0"])
      s.add_development_dependency(%q<method_source>.freeze, [">= 0"])
      s.add_development_dependency(%q<unparser>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3.2"])
      s.add_runtime_dependency(%q<elasticsearch>.freeze, [">= 1.0.0"])
    else
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<appraisal>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.4.0"])
      s.add_dependency(%q<rspec-its>.freeze, [">= 0"])
      s.add_dependency(%q<rspec-collection_matchers>.freeze, [">= 0"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_dependency(%q<database_cleaner>.freeze, [">= 0"])
      s.add_dependency(%q<elasticsearch-extensions>.freeze, [">= 0"])
      s.add_dependency(%q<resque_spec>.freeze, [">= 0"])
      s.add_dependency(%q<method_source>.freeze, [">= 0"])
      s.add_dependency(%q<unparser>.freeze, [">= 0"])
      s.add_dependency(%q<activesupport>.freeze, [">= 3.2"])
      s.add_dependency(%q<elasticsearch>.freeze, [">= 1.0.0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.4.0"])
    s.add_dependency(%q<rspec-its>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-collection_matchers>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<database_cleaner>.freeze, [">= 0"])
    s.add_dependency(%q<elasticsearch-extensions>.freeze, [">= 0"])
    s.add_dependency(%q<resque_spec>.freeze, [">= 0"])
    s.add_dependency(%q<method_source>.freeze, [">= 0"])
    s.add_dependency(%q<unparser>.freeze, [">= 0"])
    s.add_dependency(%q<activesupport>.freeze, [">= 3.2"])
    s.add_dependency(%q<elasticsearch>.freeze, [">= 1.0.0"])
  end
end
