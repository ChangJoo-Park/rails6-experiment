class UsersController < ApplicationController
  def show
    @user = User.find_by_id_with_posts(params[:id])
  end
end
