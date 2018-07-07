require 'unf'

module Service::VideoService
  extend ActiveSupport::Concern

  include Util::YoutubeApiUtil
  include Util::AnalyzeEntityUtil

  # ビデオの検索
  def search_video(params)
    if params[:t]
      # タグ検索
      tag = Tag.where(:name => params[:t]).first
      tag.videos
    elsif params[:k]
      # キーワード検索
      Video.where('title LIKE(?)', "%#{params[:k]}%")
    end
  end

  # 一覧に表示する情報
  def get_first_video(video_rails)
    video_list_info =[]
    videos = Video.where(:video_rail_id => video_rails.map{|v| v.id})
    videos.each{ |video|
      next unless video_list_info[video.video_rail_id] == nil # 最初の動画情報を格納
      video_list_info[video.video_rail_id] = {:title => video.title, :thumbnail => video.thumbnail}
    }
    video_list_info
  end

  # ビデオの新規登録
  def regist_video(video_ids, titles)

    @video_rail = VideoRail.create
    @video_rail.user_id = session[:user_id]
    @video_rail.save

    video_ids.each_with_index { |video_id, i|
      # ビデオの情報を取得
      video_info = get_video_info(video_id)
      # 動画のサムネイル
      video_thumbnail_url = video_info['items'][0]['snippet']['thumbnails']['high']['url']

      # 動画の再生時間
      video_duration = video_info['items'][0]['contentDetails']['duration']
      video_hour = (video_duration =~ /^PT([0-9]+)H/) ? video_duration.match(/^PT([0-9]+)H/)[1].to_i : 0
      video_minutes = (video_duration =~ /([0-9]+)M/) ? video_duration.match(/([0-9]+)M/)[1].to_i : 0
      video_second = (video_duration =~ /([0-9]+)S$/) ? video_duration.match(/([0-9]+)S$/)[1].to_i : 0

      video = Video.create
      video.user_id = session[:user_id]
      video.video_rail_id = @video_rail.id
      video.sort = i
      video.youtube_id = video_id
      video.title = titles[i]
      video.thumbnail = video_thumbnail_url
      video.play_time = (video_hour * 3600 + video_minutes * 60 + video_second)

      unless video.save
        # 登録の失敗
        false
      end

      # 動画タイトルの解析
      analyzed_video_info = analyze_sentence(titles[i])

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

      video.tags = tags
      video.save
    }

    true
  end

  # ユーザのビデオレールであるか
  def is_own_video_rail?(video_rail_id)
    p video_rail_id
    if VideoRail.where(:id => video_rail_id, :user_id => session[:user_id]).size > 0
      true
    else
      false
    end
  end

end