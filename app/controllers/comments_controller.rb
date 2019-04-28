class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = post.comments.create(comment_params)
    comment.user = current_user

    respond_to do |format|
      if comment.save
        format.html { redirect_to post, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: post }
      else
        format.html { redirect_to post, notice: 'Comment was created failed.' }
        format.json { render json: post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
