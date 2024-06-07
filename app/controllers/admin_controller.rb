class AdminController < ApplicationController
  include ActionView::Helpers::DateHelper

  def dashboard
    @product_purchases = current_user.product_purchases.order(created_at: :desc).map {|o| {
      user: o.user.display_name,
      product: o.product.name,
      created_at: o.created_at,
      class_name: o.class.name,
    }}
    @followers = current_user.followers.order(created_at: :desc).map {|o| {
      user: o.display_name,
      created_at: o.created_at,
      class_name: o.class.name,
    }}

    @tips = current_user.tips.order(created_at: :desc).map {|o| {
      user: o.user_display_name,
      amount: o.amount,
      created_at: o.created_at,
      class_name: o.class.name,
    }}

    @activities = @product_purchases + @followers + @tips
    @activities.sort_by! { |activity| activity[:created_at] }.reverse!
  end

  def library
    @purchases_tab = params[:tab].nil?
    @wishlist_tab = params[:tab] == "wishlist"
    if @purchases_tab
      @purchases = current_user.purchases.order(created_at: :desc).includes(:product)
    elsif @wishlist_tab
      @wishlist_items = current_user.wishlist_items.order(created_at: :desc)
    end
  end

  def emails
    @posts = current_user.posts.order(created_at: :desc)
  end
end
