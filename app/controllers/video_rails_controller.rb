class VideoRailsController < ApplicationController

  include Service::VideoService

  def index
    if params[:t]
      videos = search_video(params)
      rail_id_list =  videos.map{|v| v.video_rail_id}
      @video_rails = VideoRail.where(:id => rail_id_list)
    else
      @video_rails = VideoRail.all
    end

    @video_list_info =[]
    @video_rails.each{ |video_rail|
      video = video_rail.videos.first
      @video_list_info.push({:title => video.title, :thumbnail => video.thumbnail})
    }
  end

  def show
    @videos = Video.where(:video_rail_id => params[:id])
  end

  def new

  end

  def confirm
    logger.info params[:video_url]

    @video_infos = []
    params[:video_url].each { |url|
      video_id = url.split('v=')[1].split('&')[0]
      info = get_video_info(video_id)
      title = info['items'][0]['snippet']['title']
      @video_infos.push({:video_id => video_id, :title => title})
    }
  end

  def create
    video_ids = params[:video_id]
    titles = params[:title]

    success_flag = regist_video video_ids, titles

    respond_to do |format|
      if success_flag
        format.html { redirect_to @video_rail, notice: 'Product was successfully created.' }
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
