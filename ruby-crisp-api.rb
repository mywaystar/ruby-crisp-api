Gem::Specification.new do |s|
  s.name        = 'ruby-crisp-api'
  s.version     = '1.0.0'
  s.date        = Date.today
  s.summary     = "Crisp Ruby API"
  s.description = "Crisp Ruby API"
  s.authors     = ["Baptiste Jamin"]
  s.email       = 'baptiste@crisp.im'
  s.files       = ["lib/crisp.rb"]
  s.homepage    = 'https://crisp.im'
  s.license     = 'MIT'

  s.require_paths         = ['lib']
  s.required_ruby_version = '>= 2.2'
  s.add_dependency 'rest-client', '~> 1.8.0'
  s.add_dependency 'socket.io-client-simple', '~> 2.1.0'
  s.add_dependency 'event_emitter', '~> 0.2.4'
end
