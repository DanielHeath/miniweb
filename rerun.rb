#!/usr/bin/env ruby

require 'rubygems'
require 'pathname'
require 'listen'
require 'rb-fsevent'
require 'rb-inotify'

$pid = nil
def relaunch_server
  puts 'relaunch'
  if $pid
  	Process.kill('KILL', $pid)
  	$pid = nil
  end
  $pid = Process.fork do
  	puts `bundle`
  	Process.exec 'bundle exec shotgun web.rb -p 3111 --host 0.0.0.0'
  end
  sleep(3)
  puts $pid
end


relaunch_server

base = File.expand_path("..", __FILE__)

Listen.to(base) do |modified, added, removed|
  if (modified + added + removed).any? {|f| f =~ /Gemfile/}
  	relaunch_server
  end
end
