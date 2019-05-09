# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.create(comment_params)
    @comment.user = current_user
    @comment.save
    if @comment.errors.any?
      render partial: "error", comment: @comment, status: :bad_request
    else
      ActionCable.server.broadcast("post_#{post.id}", { type: 'comment', event: 'created', payload: @comment, html: render(@comment) })
    end
  end

  def update; end

  def destroy; end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
