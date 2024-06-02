class PurchasesController < ApplicationController
  def show
    @purchase = current_user.purchases.find_by(id: params[:purchase_id])
    if @purchase.nil?
      redirect_to library_path
    else
      @product = @purchase.product
    end
  end
end