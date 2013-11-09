root = "#{Dir.getwd}"
 
bind "unix:///tmp/cosito.sock"
pidfile "#{root}/tmp/pids/cosito.pid"
rackup "#{root}/config.ru"
state_path "#{root}/tmp/pids/cosito.state"
