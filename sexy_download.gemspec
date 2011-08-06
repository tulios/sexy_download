# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sexy_download}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["T\303\272lio Ornelas"]
  s.date = %q{2011-08-05}
  s.default_executable = %q{sexy_download}
  s.description = %q{A Script that retrieves google chrome cookies and calls aria2c for multithreading download}
  s.email = %q{ornelas.tulio@gmail.com}
  s.executables = ["sexy_download"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/sexy_download",
     "lib/sexy_download.rb",
     "sexy_download.gemspec"
  ]
  s.homepage = %q{http://github.com/tulios/sexy_download}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{A Script that retrieves google chrome cookies and calls aria2c for multithreading download}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sqlite3>, ["~> 1.3.3"])
      s.add_runtime_dependency(%q<activerecord>, ["~> 3.0.9"])
    else
      s.add_dependency(%q<sqlite3>, ["~> 1.3.3"])
      s.add_dependency(%q<activerecord>, ["~> 3.0.9"])
    end
  else
    s.add_dependency(%q<sqlite3>, ["~> 1.3.3"])
    s.add_dependency(%q<activerecord>, ["~> 3.0.9"])
  end
end

