require_relative "lib/simple/liquid"

Gem::Specification.new do |spec|
  spec.name = "simple-liquid"
  spec.version = Simple::Liquid::VERSION
  spec.authors = ["localhostdotdev"]
  spec.email = ["localhostdotdev@protonmail.com"]
  spec.summary = "safe simple way to render a liquid template"
  spec.homepage = "https://github.com/simple-updates/simple-liquid"
  spec.license = "MIT"
  spec.files = `git ls-files`.split("\n")
  spec.require_paths = ["lib"]
  spec.add_dependency "liquid", "~> 4.0"
end
