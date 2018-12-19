require 'httpclient'

module Util::AnalyzeEntityUtil
  extend ActiveSupport::Concern

  def analyze_sentence(sentence)
    request_content = {:document => {:type => 'PLAIN_TEXT', :content => "#{sentence}"}, :encodingType => 'UTF8'}
    client = HTTPClient.new
    endpoint_url = "https://language.googleapis.com/v1/documents:analyzeEntities?key=#{ENV['GOOGLE_API_KEY']}"
    logger.info("----- Start Request -----\n" + request_content.to_s + "\n----- End Request -----")
    res = client.post_content(endpoint_url.to_s, request_content.to_json, 'Content-Type' => 'application/json')
    logger.info("----- Start Response -----\n" + res + "\n----- End Response -----")

    JSON.parse(res)
  end

end