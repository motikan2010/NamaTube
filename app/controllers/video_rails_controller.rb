class VideoRailsController < ApplicationController

  include Service::VideoService

  def index
    if params[:t] || params[:k]
      videos = search_video(params)
      rail_id_list =  videos.map{|v| v.video_rail_id}
      p rail_id_list
      @video_rails = VideoRail.where(:id => rail_id_list)
    else
      @video_rails = VideoRail.all
    end

    # 一覧に表示する情報
    @video_list_info =[]
    videos = Video.where(:video_rail_id => @video_rails.map{|v| v.id})
    videos.each{ |video|
      next unless @video_list_info[video.video_rail_id] == nil # 最初の動画情報を格納
      @video_list_info[video.video_rail_id] = {:title => video.title, :thumbnail => video.thumbnail}
    }

    @search_word = params[:k]
  end

  def show
    @videos = Video.where(:video_rail_id => params[:id])
    @messages = Message.where(:video_rail_id => params[:id])
  end

  def new

  end

  def confirm
    logger.info params[:video_url]

    errors = []
    @video_infos = []
    params[:video_url].each_with_index { |url, index|
      v_param = url.split('v=')[1]
      if v_param != nil
      video_id = v_param.split('&')[0]
        info = get_video_info(video_id) # 動画の情報取得
        if info['items'].size == 0
          errors.push({:index => index, :msg => 'URLが正しくありません'})
        else
          title = info['items'][0]['snippet']['title']
          @video_infos.push({:video_id => video_id, :title => title})
        end
      else
        errors.push({:index => index, :msg => 'URLを入力してください'})
      end
    }


    respond_to do |format|
      if errors.size == 0
        format.html { render action: 'confirm' }
      else
        @video_url_json = params[:video_url].to_json
        @errors_json = errors.to_json
        format.html { render action: 'new' }
      end
    end
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
