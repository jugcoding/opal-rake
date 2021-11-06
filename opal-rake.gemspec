require_relative 'lib/opal/rake/version'

Gem::Specification.new do |spec|
  spec.name         = 'opal-rake'
  spec.version      = Opal::Rake::VERSION
  spec.authors      = ['jugcoding']
  spec.email        = '17433583+jugcoding@users.noreply.github.com'

  spec.summary      = 'Rake support for Opal.'
  spec.homepage     = 'https://github.com/jugcoding/opal-rake/blob/master/README.md'
  spec.license      = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/jugcoding/opal-rake'
  spec.metadata['changelog_uri'] = 'https://github.com/jugcoding/opal-rake/blob/master/CHANGELOG.md'

  spec.required_ruby_version = Gem::Requirement.new('>= 2.5', '< 3.1')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  files = Dir.chdir(__dir__) { `git ls-files -z`.split("\x0") }

  spec.files = files.grep_v(%r{^(test|spec|features)/})
  spec.test_files = files.grep(%r{^(test|spec|features)/})
  spec.bindir = "exe"
  spec.executables = files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rake', ">= 4.0"
  spec.add_dependency 'opal', [">= 1.0", "< 2.0"]
  spec.add_dependency 'tilt', '>= 1.4'
  spec.add_dependency 'rainbow'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'ejs'
  spec.add_development_dependency 'pry'
end
