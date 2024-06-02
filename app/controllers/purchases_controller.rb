class PurchasesController < ApplicationController
  def show
    @purchase = current_user.purchases.find_by(id: params[:purchase_id])

    if @purchase.nil?
      redirect_to library_path
    else
      @review = Review.new
      @product = @purchase.product
    end
  end

  def submit_review
    @review = Review.new(
      user: current_user,
      product_id: review_params[:product_id],
      purchase_id: review_params[:purchase_id],
      body: review_params[:body],
      rating: review_params[:rating],
    )
    if @review.save
      redirect_to purchase_library_path(purchase_id: review_params[:purchase_id]), notice: "Review submitted!"
    else
      @purchase = current_user.purchases.find_by(id: review_params[:purchase_id])
      @product = @purchase.product
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_purchase
    @product = @purchase&.product
  end

  def review_params
    params.require(:review).permit(:body, :rating, :product_id, :purchase_id)
  end
end