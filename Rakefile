begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "sexy_download"
    gemspec.summary = "A Script that retrieves google chrome cookies and calls aria2c for multithreading download"
    gemspec.description = "A Script that retrieves google chrome cookies and calls aria2c for multithreading download"
    gemspec.email = "ornelas.tulio@gmail.com"
    gemspec.homepage = "http://github.com/tulios/sexy_download"
    gemspec.authors = ["Túlio Ornelas"]
                                         
    gemspec.add_runtime_dependency("sqlite3", "~> 1.3.3")
    gemspec.add_runtime_dependency("activerecord", "~> 3.0.9")
    
    gemspec.executables = ["sexy_download"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end