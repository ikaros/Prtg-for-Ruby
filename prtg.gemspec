Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'prtg'
  s.version     = '0.0.1p2'
  s.summary     = 'Wrapper for the prtg network monitor api (http://www.paessler.com/prtg)'
  s.description = 'This gem is a wrapper around the prth http api.Prtg is an network monitoring solution which provides a api to retrieve several information about monitored devices.'

  s.required_ruby_version     = '>= 1.9.2'
  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency('xml-simple', '>= 1.1.1')

  s.files = Dir.glob("lib/**/*")

  s.author   = 'Konstantin Kanellopoulos'
  s.homepage = "http://github.com/ikaros/Prtg-for-Ruby"
  s.email    = 'k@kanello.de'
end
