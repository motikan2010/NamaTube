class VideosController < ApplicationController

  include Service::VideoService

  def index
    @videos = Video.all()
  end

  def show
    @video = Video.find(params[:id])
  end

  def new

  end

  def confirm
    url = params[:video_url]

    @video_id = url.split('v=')[1]
    video_info = get_video_info(@video_id)
    @video_title = video_info['items'][0]['snippet']['title']
  end

  def create
    video_id = params[:video_id]
    title = params[:title]

    @video = regist_video video_id, title

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
