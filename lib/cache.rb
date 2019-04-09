require 'yaml'
require 'redis'

module Cache
  class << self
    attr_accessor :redis

    def get(key)
      Cache.redis.get(key)
    end

    def set(key, value, ttl=nil)
      if ttl
        Cache.redis.setex(key, ttl, value)
      else
        Cache.redis.set(key, value)
      end
    end

    def fetch(key)
      value = get(key)
      value = yield if block_given? && value.nil?
      value
    end

    def establish_connection
      redis_config = YAML.load_file(File.join(Dir.pwd, 'config', 'redis.yml'))
      Cache.redis.client.disconnect if Cache.redis
      Cache.redis = Redis.new(:host => redis_config["host"], :port => redis_config["port"])
    end
  end
end
