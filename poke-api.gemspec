lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'poke-api/version'

Gem::Specification.new do |spec|
  spec.name = 'poke-api'
  spec.summary = 'Poke API'

  spec.description = 'An API wrapper for Pokemon GO'
  spec.version = Poke::API::VERSION

  spec.date = '2016-07-22'
  spec.authors = ['Nabeel Amjad']
  spec.licenses = ['MIT']

  spec.files = Dir.glob('lib/**/*')
  spec.homepage = 'https://github.com/nabeelamjad/poke-api'

  spec.add_runtime_dependency 'httpclient', '2.8.0'
  spec.add_runtime_dependency 'geocoder', '1.3.7'
  spec.add_runtime_dependency 'google-protobuf', '~> 3.0.0.alpha'
end
