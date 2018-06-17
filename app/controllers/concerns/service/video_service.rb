require 'unf'

module Service::VideoService
  extend ActiveSupport::Concern

  include Util::YoutubeApiUtil
  include Util::AnalyzeEntityUtil

  # ビデオの検索
  def search_video(params)
    tag = Tag.where(:name => params[:t]).first
    tag.videos
  end

  # ビデオの新規登録
  def regist_video(video_id, title)
    # ビデオの情報を取得
    video_info = get_video_info(video_id)
    video_thumbnail_url = video_info['items'][0]['snippet']['thumbnails']['high']['url']

    @video = Video.create
    @video.user_id = session[:user_id]
    @video.url = "https://www.youtube.com/embed/#{video_id}"
    @video.title = title
    @video.thumbnail = video_thumbnail_url
    @video.source_type = 1

    unless @video.save
      # 登録の失敗
      false
    end

    # 動画タイトルの解析
    analyzed_video_info = analyze_sentence(title)

    # タグの正規化
    tags = []
    analyzed_video_info['entities'].each { |value|
      UNF::Normalizer.normalize(value['name'], :nfkc).downcase.split(' ').each {|tag_name|
        if tag_name.size >= 3
          tag = Tag.where(:name => tag_name).first
          if tag == nil
            # 存在しないタグの追加
            tag = Tag.create
            tag.name = tag_name
            tag.save
          end
          tags.push(tag)
        end
      }
    }

    @video.tags = tags
    @video.save
  end

end