require './lib/cache.rb'
require './lib/token.rb'
require './server'

Cache.establish_connection

run Sinatra::Application


