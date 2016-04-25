$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "martinet/identity"

Gem::Specification.new do |spec|
  spec.name = martinet::Identity.name
  spec.version = martinet::Identity.version
  spec.platform = Gem::Platform::RUBY
  spec.authors = ["Tang Rufus"]
  spec.email = ["tangrufus@gmail.com"]
  spec.homepage = ""
  spec.summary = "TODO: Add gem summary here."
  spec.description = "TODO: Add gem description here."
  spec.license = "MIT"

  if ENV["RUBY_GEM_SECURITY"] == "enabled"
    spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem")
    spec.cert_chain = [File.expand_path("~/.ssh/gem-public_cert.pem")]
  end

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "gemsmith", "~> 7.6"
  spec.add_development_dependency "codeclimate-test-reporter"

  spec.files = Dir["lib/**/*", "vendor/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.require_paths = ["lib"]
end
