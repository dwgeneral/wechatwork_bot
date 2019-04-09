require './base'

module Token
  class << self
    def access_token_url
      API_ENDPOINT + "/gettoken?corpid=#{CORP_ID}&corpsecret=#{AGENT_SECRET}"
    end

    def cache_key
      "access_token_#{AGENT_ID}"
    end

    def get_access_token
      @access_token ||= Cache.get(cache_key)
      refresh_access_token unless @access_token
    end

    def refresh_access_token
      response = RestClient.get(access_token_url)
      result = JSON.parse(response.body)
      return result if result["errcode"] != 0
      Cache.set(cache_key, result["access_token"], result["expires_in"])
      result["access_token"]
    end
  end
end
