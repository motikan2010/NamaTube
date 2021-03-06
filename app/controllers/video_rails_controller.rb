class VideoRailsController < ApplicationController

  include Service::VideoService

  # ログインユーザのみアクセス可能
  before_action :authenticate, only: [:new, :create, :edit, :update, :destroy]

  # 登録者以外はトップにリダイレクト
  before_action -> { redirect_to root_path unless is_own_video_rail?(params[:id]) }, only: [:edit, :update]

  def index
    if params[:t] || params[:k]
      videos = search_video(params)
      rail_id_list =  videos.map{|v| v.video_rail_id}
      @video_rails = VideoRail.where(:id => rail_id_list, :deleted_at => nil).order({ id: :desc })
    else
      @video_rails = VideoRail.where(:deleted_at => nil).order({ id: :desc })
    end

    @video_list_info = get_first_video @video_rails
    @search_word = params[:k]
  end

  def show
    @videos = Video.where(:video_rail_id => params[:id]).order(:sort)
    @messages = Message.where(:video_rail_id => params[:id])
  end

  # 動画レールの作成ページ
  def new

  end

  def confirm
    logger.info(params[:video_url])

    errors = []
    @video_infos = []
    params[:video_url].each_with_index { |url, index|
      v_param = url.split('v=')[1]
      if v_param != nil
      video_id = v_param.split('&')[0]
        info = get_video_info(video_id) # 動画の情報取得
        logger.info(info)
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
        format.html { redirect_to @video_rail, notice: '作成が完了しました' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
    @id = params[:id]
  end

  def update
    sort_info_array = params[:sort]
    sort_info_array.each { |sort, video_id|
      Video.where(:id => video_id, :user_id => session[:user_id]).update_all(sort: sort)
    }

    redirect_to edit_video_rail_path(params[:id]), notice: '更新が完了しました'
  end

  # 削除
  def destroy
    video_rail = VideoRail.find(params[:id])
    if video_rail.user_id == session[:user_id]
      video_rail.destroy
      redirect_to mypage_videos_path, notice: '削除しました'
    else
      redirect_to mypage_videos_path
    end
  end

end
