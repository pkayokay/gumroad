class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @activities = []
  end

  def profile
    @user = User.find_by(username: params[:username])
    redirect_to root_path if @user.nil?

    @products = @user.products.published
    @follower = Follower.new
  end

  def subscribe
    follower_params = params.require(:follower).permit(:email)
    @target_user = User.find_by(username: params[:username])
    @user = User.find_by(email: follower_params[:email])
    @follower = Follower.find_by(email: follower_params[:email]) || Follower.new(user: @user, target_user: @target_user, email: follower_params[:email])

    if @follower.save
      flash[:notice] = "Subscribed!"
    else
      flash[:alert] = "Something went wrong, try again."
    end
    redirect_to profile_path(username: params[:username])
  end

  def product
    @user = User.find_by(username: params[:username])
    redirect_to root_path if @user.nil?

    @product = @user.products.find_by(slug: params[:product_slug])
    redirect_to root_path if @product.nil?
  end
end
