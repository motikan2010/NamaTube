class VideosController < ApplicationController

  include Service::YoutubeApiService
  include Service::AnalyzeEntityService

  def index
    @videos = Video.all()
  end

  def show
    @video = Video.find(params[:id])
  end

  def new

  end

  def confirm
    url = params[:url]

    @video_id = url.split('v=')[1]
    video_info = get_video_info(@video_id)
    @video_title = video_info['items'][0]['snippet']['title']
  end

  def create
    video_id = params[:video_id]
    title = params[:title]

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

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Product was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update

  end

  def destroy

  end

end
