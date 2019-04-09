require './base'

namespace '/api/v1' do
  namespace '/wx' do
    before do
      content_type :json
      @access_token = Token.get_access_token
    end

    get '/get_access_token' do
      @access_token
    end

    # 创建群聊会话
    # params do
    #   :name,
    #   :owner, optional
    #   :userlist,
    #   :chatid, optional, values: [0-9a-zA-Z], max: 32char 建议自己指定，因为没打算存
    # end
    post '/appchat/create' do
      @params = JSON.parse(request.body.read)
      response = RestClient.post(create_appchat_url, @params)
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
      RestClient.post(send_appchat_message_url, @params)
    end

    # 获取标签成员List
    get '/tag/get' do
      response = RestClient.get(get_tag_members_url)
      userlist = JSON.parse(response.body)
    end

    # 发送【磁场功能上线通知】
    post '/magnet/send_deploy_message' do
    end

  end # namesapce /wx
end # namespace /api/v1
