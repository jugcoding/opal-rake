source 'https://rubygems.org'
gemspec

opal_path = File.expand_path('../opal')

if ENV['OPAL_VERSION']
  gem 'opal', ENV['OPAL_VERSION']
elsif File.exist? opal_path
  gem 'opal', path: opal_path
else
  gem 'opal', github: 'opal/opal'
end

rack_version = ENV['RACK_VERSION']
rake_version = ENV['RAKE_VERSION']

gem 'rack', rack_version if rack_version
gem 'rake', rake_version if rake_version
gem 'rainbow'
