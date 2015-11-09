Gem::Specification.new do |s|
  s.name = 'dom_render'
  s.version = '0.1.0'
  s.summary = 'Designed to render HTML'
  s.authors = ['James Robertson']
  s.files = Dir['lib/dom_render.rb']
  s.add_runtime_dependency('rexle', '~> 1.3', '>=1.3.9')
  s.signing_key = '../privatekeys/dom_render.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/dom_render'
end
