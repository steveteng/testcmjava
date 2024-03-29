#!/usr/bin/env ruby
require 'webrick'
include WEBrick

config = {}
config.update(:Port => 8080)
config.update(:BindAddress => ARGV[0])
config.update(:DocumentRoot => ARGV[1])
server = HTTPServer.new(config)
['INT', 'TERM'].each {|signal|
  trap(signal) {server.shutdown}
}

server.mount_proc '/' do |req, res|
  res.body = "#{ENV['OPENSHIFT_DIY_IP']}"#File.read 'index1.html'
end

server.start
