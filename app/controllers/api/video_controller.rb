class Api::VideoController < ApplicationController

  before_action :authenticate

  def show
    videos = Video.select(:youtube_id, :title, :thumbnail, :play_time).where(:video_rail_id => params[:id])
    render json: {staus: 200, data: videos}
  end
end
