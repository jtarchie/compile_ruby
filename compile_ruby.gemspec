# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "compile_ruby/version"

Gem::Specification.new do |s|
  s.name        = "compile_ruby"
  s.version     = CompileRuby::VERSION
  s.authors     = ["JT Archie"]
  s.email       = ["jtarchie@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "compile_ruby"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"

  s.add_dependency "RubyInline"
  s.add_dependency "ruby_parser"
end
