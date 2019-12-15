
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hockey_equipment_deals/version"

Gem::Specification.new do |spec|
  spec.name          = "hockey_equipment_deals"
  spec.version       = HockeyEquipmentDeals::VERSION
  spec.authors       = ["'Michael Carroll'"]
  spec.email         = ["'carrollm2@gmail.com'"]

  spec.summary       = %q{Finding  all the greatest hockey equipment deals.}
  spec.description   = %q{Finding  all the greatest hockey equipment deals.}
  spec.homepage      = "http://icewarehouse.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["http://icewarehouse.com"] = spec.homepage
    spec.metadata["http://icewarehouse.com"] = "TODO: Put your gem's public repo URL here."
    spec.metadata["http://icewarehouse.com"] = "TODO: Put your gem's CHANGELOG.md URL here."
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry" 
  spec.add_development_dependency "nokogiri" 
end
