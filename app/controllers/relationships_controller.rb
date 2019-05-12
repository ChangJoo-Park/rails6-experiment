class RelationshipsController < ApplicationController
  # TODO: Add before_action
  def create
    @user = User.find(params[:user])
    current_user.follow!(@user)
    redirect_to @user
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow!(@user)
    redirect_to @user
  end
end
