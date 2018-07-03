class MypageController < ApplicationController

  include Service::VideoService

  before_action :authenticate

  def index

  end

  def videos
    @video_rails = VideoRail.where(:user_id => session[:user_id])
    @video_list_info = get_first_video @video_rails
  end

end