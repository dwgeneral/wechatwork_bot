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


def send_appchat_message_url
  API_ENDPOINT + "/appchat/send?access_token=#{@access_token}"
end

def create_appchat_url
  API_ENDPOINT + "/appchat/create?access_token=#{@access_token}"
end

# 获取标签成员List, 默认获取【磁场功能上线通知组】标签组
def get_tag_members_url(tagid = 1)
  API_ENDPOINT + "/tag/get?access_token=#{@access_token}&tagid=#{tagid}"
end
