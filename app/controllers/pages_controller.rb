class PagesController < ApplicationController
  before_action :set_product, only: [:product, :product_checkout]
  skip_before_action :authenticate_user!

  def index
    @categories = Category.order(name: :asc)
    if params[:category].present?
      @category = Category.find_by(slug: params[:category])
      @products = Product.order(created_at: :desc).published.joins(:product_category).where(product_category: {category: @category})
    else
      @products = Product.order(created_at: :desc).published.limit(20)
    end
  end

  def profile
    @user = User.find_by(username: params[:username])
    redirect_to root_path if @user.nil?

    @products = @user.products.published
    @posts = @user.posts.order(created_at: :desc)
    @follower = Follower.new
  end

  def tips
    @user = User.find_by(username: params[:username])
    redirect_to root_path if @user.nil?

    if @user == current_user
      flash[alert] =  "You can't tip yourself"
      redirect_to root_path
    end

    @tip = Tip.new
  end

  def give_tip
    @target_user = User.find_by(username: params[:username])
    tip_params = params.require(:tip).permit(:email, :amount)
    @tip = Tip.new(tip_params.merge(target_user: @target_user))

    if @tip.save
      flash[:notice] = "Tip sent!"
      redirect_to profile_path(username: @target_user.username)
    else
      redirect_to tips_path(username: @target_user.username), alert: @tip.errors.full_messages.join(", ")
    end
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
  end

  def product_checkout
    @purchase = Purchase.new

    if @user == current_user
      flash[alert] =  "You can't purchase your own product."
      redirect_to root_path
    end
  end

  def purchase
    @product = Product.find(params[:product_id])
    @product_user = @product.user

    if user_signed_in?
      @follower = @product_user.followers.find_by(email: current_user.email) || Follower.create(user: current_user, email: current_user.email, target_user: @product_user)
      @purchase = Purchase.create(follower: @follower, user: current_user, price: @product.price, product: @product)
      flash[:notice] = "Purchased!"
      redirect_to purchase_library_path(purchase_id: @purchase.id)
    else
      email = params[:purchase][:email]&.strip
      password = params[:purchase][:password]

      @user = User.find_by(email: email)
      if @user
        flash[:alert] = "Account exists, sign in before purchasing the product."
        redirect_to product_checkout_path(username: @product_user.username, product_slug: @product.slug)
      else
        transaction = Purchase.transaction do
          @user = User.create!(email: email, password: password)
          @follower = @product_user.followers.find_by(email: email) || Follower.create!(user: @user, email: email, target_user: @product_user)
          @purchase = Purchase.create!(user: @user, follower: @follower, price: @product.price, product: @product)
        end

        if transaction
          sign_in(@user)
          flash[:notice] = "Purchased!"
          redirect_to purchase_library_path(purchase_id: @purchase.id)
        else
          flash[:alert] = "Sorry, something went wrong"
          redirect_to product_checkout_path(username: @user.username, product_slug: product.slug)
        end
      end
    end
  end

  def set_product
    @user = User.find_by(username: params[:username])
    redirect_to root_path if @user.nil?

    @product = @user.products.find_by(slug: params[:product_slug])
    redirect_to root_path if @product.nil?

    if @product.present?
      if user_signed_in? && @existing_purchase = current_user.purchases.find_by(product_id: @product.id)
        @already_purchased = true
      end
    end
  end
end
