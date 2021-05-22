class CommentsChannel < ApplicationCable::Channel
  def subscribed
    # puts 'stream_from'
    stream_from "comments"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
