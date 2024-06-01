class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  def profile
    @user = User.find_by(username: params[:username])
    redirect_to root_path if @user.nil?

    @products = @user.products.published
  end

  def product
    @user = User.find_by(username: params[:username])
    redirect_to root_path if @user.nil?

    @product = @user.products.find_by(slug: params[:product_slug])
    redirect_to root_path if @product.nil?
  end
end
