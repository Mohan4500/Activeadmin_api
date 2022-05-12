# -*- encoding: utf-8 -*-
# stub: bx_block_search 0.1.4 ruby lib

Gem::Specification.new do |s|
  s.name = "bx_block_search".freeze
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://gemfury.com" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Arihant Nahar".freeze]
  s.date = "2021-11-05"
  s.description = "Description of BxBlockSearch.".freeze
  s.email = ["arihant.nahar@protonshub.com".freeze]
  s.homepage = "https://gitlab.builder.ai/builder/builder-bx/bx/blocks/ruby/engines/bx_block_search".freeze
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Summary of BxBlockSearch.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>.freeze, ["~> 6.0.3", ">= 6.0.3.6"])
      s.add_runtime_dependency(%q<account_block>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<builder_json_web_token>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<builder_base>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<bx_block_chat>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<bx_block_comments-568532a5>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<bx_block_login-3d0582b5>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<bx_block_posts-3dc5b993>.freeze, ["~> 0.0.9"])
      s.add_development_dependency(%q<pg>.freeze, [">= 0"])
      s.add_development_dependency(%q<acts-as-taggable-on>.freeze, [">= 0"])
      s.add_development_dependency(%q<byebug>.freeze, [">= 0"])
      s.add_development_dependency(%q<cane>.freeze, [">= 0"])
      s.add_development_dependency(%q<factory_bot>.freeze, [">= 0"])
      s.add_development_dependency(%q<faker>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake_tasks>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>.freeze, [">= 0"])
      s.add_development_dependency(%q<shoulda-matchers>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rails>.freeze, ["~> 6.0.3", ">= 6.0.3.6"])
      s.add_dependency(%q<account_block>.freeze, [">= 0"])
      s.add_dependency(%q<builder_json_web_token>.freeze, [">= 0"])
      s.add_dependency(%q<builder_base>.freeze, [">= 0"])
      s.add_dependency(%q<bx_block_chat>.freeze, [">= 0"])
      s.add_dependency(%q<bx_block_comments-568532a5>.freeze, [">= 0"])
      s.add_dependency(%q<bx_block_login-3d0582b5>.freeze, [">= 0"])
      s.add_dependency(%q<bx_block_posts-3dc5b993>.freeze, ["~> 0.0.9"])
      s.add_dependency(%q<pg>.freeze, [">= 0"])
      s.add_dependency(%q<acts-as-taggable-on>.freeze, [">= 0"])
      s.add_dependency(%q<byebug>.freeze, [">= 0"])
      s.add_dependency(%q<cane>.freeze, [">= 0"])
      s.add_dependency(%q<factory_bot>.freeze, [">= 0"])
      s.add_dependency(%q<faker>.freeze, [">= 0"])
      s.add_dependency(%q<rake_tasks>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
      s.add_dependency(%q<shoulda-matchers>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>.freeze, ["~> 6.0.3", ">= 6.0.3.6"])
    s.add_dependency(%q<account_block>.freeze, [">= 0"])
    s.add_dependency(%q<builder_json_web_token>.freeze, [">= 0"])
    s.add_dependency(%q<builder_base>.freeze, [">= 0"])
    s.add_dependency(%q<bx_block_chat>.freeze, [">= 0"])
    s.add_dependency(%q<bx_block_comments-568532a5>.freeze, [">= 0"])
    s.add_dependency(%q<bx_block_login-3d0582b5>.freeze, [">= 0"])
    s.add_dependency(%q<bx_block_posts-3dc5b993>.freeze, ["~> 0.0.9"])
    s.add_dependency(%q<pg>.freeze, [">= 0"])
    s.add_dependency(%q<acts-as-taggable-on>.freeze, [">= 0"])
    s.add_dependency(%q<byebug>.freeze, [">= 0"])
    s.add_dependency(%q<cane>.freeze, [">= 0"])
    s.add_dependency(%q<factory_bot>.freeze, [">= 0"])
    s.add_dependency(%q<faker>.freeze, [">= 0"])
    s.add_dependency(%q<rake_tasks>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_dependency(%q<shoulda-matchers>.freeze, [">= 0"])
  end
end
