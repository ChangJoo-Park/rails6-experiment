class UsersController < ApplicationController
  def show
    # 사용자 로그인 및 현재 로그인한 사용자인 경우 처리
    @user = User.find(params[:id])
    @posts = Post.published_by_user(@user)
  end
end
