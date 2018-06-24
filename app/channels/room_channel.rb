class RoomChannel < ApplicationCable::Channel

  def subscribed
    stream_from "room_channel_#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    p '---'
    p params
    Message.create!(content: data['message'], user_id: current_user.id, video_rail_id: params['room_id'])
  end

end
