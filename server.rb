# Require the bundler gem and then call Bundler.require to load in all gems listed in Gemfile.
require 'bundler'
Bundler.require

configure { set :server, :puma }

API_ENDPOINT = "https://qyapi.weixin.qq.com/cgi-bin".freeze

# 企业ID
CORP_ID = "wwcbba347bf458d3a8".freeze
# 小磁土应用ID
AGENT_ID= "1000005".freeze
# 每个应用有独立的secret，所以每个应用的access_token应该分开来获取
AGENT_SECRET = "pO5HHPGhnUxX_XMUtIfcqmhS_wYdOHy9tvUwVqiGZNE".freeze


namespace '/api/v1' do
  namespace '/wx' do

    before do
      content_type :json
    end

    get '/get_access_token' do
      return cache if cache
      response = RestClient.get(access_token_url)
      result = JSON.parse(response.body)
      return result if result["errcode"] != 0
      Cache.set(cache_key, result["access_token"], result["expires_in"])
      result["access_token"]
    end

  end
end

def access_token_url
  API_ENDPOINT + "/gettoken?corpid=#{CORP_ID}&corpsecret=#{AGENT_SECRET}"
end

def cache_key
  "access_token_#{AGENT_ID}"
end

def cache
  Cache.get(cache_key)
end
