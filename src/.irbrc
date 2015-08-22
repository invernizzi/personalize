begin
  require "pry"
  Pry.start
  exit
rescue LoadError => e
  warn "=> Unable to load pry"
  require 'rubygems'
  require 'wirble'
  Wirble.init
  Wirble.colorize
  IRB.conf[:AUTO_INDENT] = true
  IRB.conf[:USE_READLINE] = true
  ARGV.concat [ "--readline", "--prompt-mode", "simple" ]
  require 'irb/ext/save-history'
  IRB.conf[:SAVE_HISTORY] = 200
  IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"
end
