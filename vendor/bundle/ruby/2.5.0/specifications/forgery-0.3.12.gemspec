# -*- encoding: utf-8 -*-
# stub: forgery 0.3.12 ruby lib

Gem::Specification.new do |s|
  s.name = "forgery".freeze
  s.version = "0.3.12"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nathan Sutton".freeze, "Brandon Arbini".freeze]
  s.date = "2011-07-18"
  s.description = "Easy and customizable generation of forged data. Can be used as a gem or a rails plugin. Includes rails generators for creating your own forgeries.".freeze
  s.email = ["nate@zencoder.com".freeze, "brandon@zencoder.com".freeze]
  s.homepage = "http://github.com/sevenwire/forgery".freeze
  s.rubyforge_project = "forgery".freeze
  s.rubygems_version = "2.7.6.2".freeze
  s.summary = "Easy and customizable generation of forged data.".freeze

  s.installed_by_version = "2.7.6.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>.freeze, ["~> 1.4"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    else
      s.add_dependency(%q<nokogiri>.freeze, ["~> 1.4"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<nokogiri>.freeze, ["~> 1.4"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
  end
end
