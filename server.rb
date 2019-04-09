require './base'

namespace '/api/v1' do
  namespace '/wx' do
    before do
      content_type :json
    end

    get '/get_access_token' do
      access_token
    end

    # 创建群聊
    # params do
    #   :name,
    #   :owner, optional
    #   :userlist,
    #   :chatid, optional, values: [0-9a-zA-Z], max: 32char 建议自己指定，因为没打算存
    # end
    post '/appchat/create' do
      params = JSON.parse(request.body.read)
      response = RestClient.post(create_appchat_url, params.to_json)
    end

    # 发送消息到群聊
    # params do
    #   :chatid
    #   :msgtype, values: ['text', 'image', 'voice', 'video', 'file', 'textcard', 'news', 'mpnews', 'markdown']
    #   :text
    #     :content, max: 2048char
    #   :safe, Boolean, default: false 保密消息
    #   refer to: https://work.weixin.qq.com/api/doc#90000/90135/90248
    post '/appchat/send' do
      params = JSON.parse(request.body.read)
      RestClient.post(send_appchat_message_url, params.to_json)
    end

    # 获取标签成员List
    get '/tag/get' do
      response = RestClient.get(get_tag_members_url)
    end

    # 发送【磁场功能上线通知】, chatid: 'ccgnsxtz'
    post '/magnet/send_deploy_message' do
    end

  end # namesapce /wx
end # namespace /api/v1

def access_token
  @access_token ||= Token.get_access_token
end

def send_appchat_message_url
  API_ENDPOINT + "/appchat/send?access_token=#{access_token}"
end

def create_appchat_url
  API_ENDPOINT + "/appchat/create?access_token=#{access_token}"
end

# 获取标签成员List, 默认获取【磁场功能上线通知组】标签组
def get_tag_members_url(tagid = 1)
  API_ENDPOINT + "/tag/get?access_token=#{access_token}&tagid=#{tagid}"
end
