class Api::VideoController < ApplicationController

  before_action :authenticate

  def show
    videos = Video.select(:id, :youtube_id, :title, :thumbnail, :play_time).where(:video_rail_id => params[:id]).order(:sort)
    render json: {staus: 200, data: videos}
  end
end
