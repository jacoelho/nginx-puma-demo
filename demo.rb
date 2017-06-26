require 'rubygems'
require 'bundler'

Bundler.require

require 'rack'
require 'rack/handler/puma'

app = Proc.new do |env|
	  ['200', {'Content-Type' => 'text/html'}, ['hello world']]
end

pid = fork do
  Rack::Handler::Puma.run app, Host: '/tmp/app.sock'
end

Process.detach(pid)
