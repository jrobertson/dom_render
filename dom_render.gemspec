Gem::Specification.new do |s|
  s.name = 'dom_render'
  s.version = '0.3.2'
  s.summary = 'Designed to render HTML'
  s.authors = ['James Robertson']
  s.files = Dir['lib/dom_render.rb']
  s.add_runtime_dependency('rexle', '~> 1.5', '>=1.5.1')
  s.signing_key = '../privatekeys/dom_render.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/dom_render'
end
