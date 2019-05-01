class UserProfileController < ApplicationController
  def edit
  end

  def update
    @user_profile = UserProfile.find(params[:user_id])

    respond_to do |format|
      if @user_profile.update(user_profile_params)
        format.html { redirect_to user_path(params[:user_id]), notice: 'User Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_profile }
      else
        format.html { redirect_to user_path(params[:user_id]) }
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def user_profile_params
    params.require(:user_profile).permit(:avatar, :bio, :username, :name, :website, :background_color, :foreground_color, :location)
  end
end
