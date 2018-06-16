require 'httpclient'

module Service::VideoService
  extend ActiveSupport::Concern

  include Util::YoutubeApiUtil
  include Util::AnalyzeEntityUtil

  def regist_video(video_id, title)
    # ビデオの情報を取得
    video_info = get_video_info(video_id)
    video_thumbnail_url = video_info['items'][0]['snippet']['thumbnails']['high']['url']

    # 動画タイトルの解析
    analyzed_title = analyze_sentence(title)

    # TODO 文字列の正規化
    # TODO タグとしての登録

    @video = Video.create
    @video.user_id = session[:user_id]
    @video.url = "https://www.youtube.com/embed/#{video_id}"
    @video.title = title
    @video.thumbnail = video_thumbnail_url
    @video.source_type = 1

    @video
  end

end