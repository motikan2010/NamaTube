class MessageBroadcastJob < ApplicationJob

  def perform(message)
    ActionCable.server.broadcast "room_channel_#{message.video_rail_id}", message: render_message(message)
  end

  private

    def render_message(message)
      ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
    end

end