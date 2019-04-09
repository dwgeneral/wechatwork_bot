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

