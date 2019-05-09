class PostChannel < ApplicationCable::Channel
  def subscribed
    stream_target = "post_#{params[:room]}"
    stream_from stream_target
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
