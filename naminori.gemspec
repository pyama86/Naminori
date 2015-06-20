# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'naminori/version'

Gem::Specification.new do |spec|
  spec.name          = "naminori"
  spec.version       = Naminori::VERSION
  spec.authors       = ["kazuhiko yamahsita"]
  spec.email         = ["pyama@pepabo.com"]

  spec.summary       = %q{LoadBarancer library on Serf.}
  spec.description   = %q{Loadbarancer library on Serf.}
  spec.homepage      = "http://ten-snapon.com"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'slack-notifier', "~> 1.2.1"
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
