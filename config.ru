require './lib/cache.rb'
require './server'

Cache.establish_connection

run Sinatra::Application


