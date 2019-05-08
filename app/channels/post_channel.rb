class PostChannel < ApplicationCable::Channel
  def subscribed
    puts "Post Channel Subscribed"
    puts "hello world #{params}"
    stream_target = "post_#{params[:room]}"
    puts "stream_target #{stream_target}"
    stream_from stream_target

    ActionCable.server.broadcast(stream_target, { message: "HELLO WORLD" })
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
