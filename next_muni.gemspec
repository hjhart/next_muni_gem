# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{next_muni}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Hart"]
  s.date = %q{2011-03-18}
  s.description = %q{A gem to access San Francisco's Next Muni API easily}
  s.email = %q{hjhart@gmail.com}
  s.extra_rdoc_files = ["CHANGELOG", "README.rdoc", "lib/next_muni.rb", "lib/next_muni/api.rb"]
  s.files = ["CHANGELOG", "README.rdoc", "Rakefile", "lib/next_muni.rb", "lib/next_muni/api.rb", "next_muni.gemspec", "Manifest"]
  s.homepage = %q{http://www.github.com/hjhart/next_muni_gem}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Next_muni", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{next_muni}
  s.rubygems_version = %q{1.5.3}
  s.summary = %q{A gem to access San Francisco's Next Muni API easily}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
