class AdminController < ApplicationController
  def dashboard
  end

  def library
    @purchases = current_user.purchases.includes(:product)
  end
end
