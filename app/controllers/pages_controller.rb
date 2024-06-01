class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  def profile
    @user = User.find_by(username: params[:username])
    redirect_to root_path if @user.nil?
  end
end
