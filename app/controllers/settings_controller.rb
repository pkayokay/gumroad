class SettingsController < ApplicationController
  def index
  end

  def update
    if current_user.update(user_params)
      redirect_to settings_path, notice: "Settings updated!"
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :is_tipping_enabled)
  end
end
