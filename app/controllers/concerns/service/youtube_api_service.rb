require 'httpclient'

module Service::YoutubeApiService
  extend ActiveSupport::Concern

  def get_video_info(video_id)
    client = HTTPClient.new
    query = {
        id: video_id,
        key: ENV['YOUTUBE_API_KEY'],
        fields: 'items(id,snippet(channelTitle,title,thumbnails),statistics)',
        part: 'snippet,contentDetails,statistics',
    }
    res = client.get('https://www.googleapis.com/youtube/v3/videos', :query => query, :follow_redirect => true)
    return JSON.parse(res.body)
  end

end