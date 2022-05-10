# frozen_string_literal: true

class HttpClientUtil
  def self.call(http_method, params)
    HTTParty.public_send(http_method, params[:url], body: params[:body], headers: params[:headers] || {})
  end
end
