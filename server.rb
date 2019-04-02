# Require the bundler gem and then call Bundler.require to load in all gems listed in Gemfile.
require 'bundler'
Bundler.require

configure { set :server, :puma }

CORP_ID = "wwcbba347bf458d3a8" # 企业ID
APP_ID= "1000005" # 应用ID
APP_SECRET = "pO5HHPGhnUxX_XMUtIfcqmhS_wYdOHy9tvUwVqiGZNE"

WX_URL = "https://qyapi.weixin.qq.com/cgi-bin"

namespace '/api/v1' do
  namespace '/wx' do

    before do
      content_type :json
    end

    #post '/merge_requests' do

    #  response = RestClient.get(MR_URL, {params: gitlab_params, "Private-Token": "dtfsWKbkPnkQony95hc5" })
    #  result = JSON.parse(response.body)

    #  bearychat_message(result)
    #end
    #
    get '/get_access_token' do

    end

  end
end

def access_token_url
  WX_URL + "/gettoken?corpid=#{COPR_ID}&corpsecret=#{COPR_SECRET}"
end

def build_message
  {
    "touser" : "abelzhu|ZhuShengben",
    "msgtype" : "text",
    "agentid" : COPR_ID,
    "text" : {
      "content" : "我就试一下"
    },
    "safe":0
  }
end
