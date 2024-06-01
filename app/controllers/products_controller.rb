class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = current_user.products
  end

  def new
    @product = Product.new(is_published: true)
  end

  def edit
  end

  def update
    if @product.update(product_create_params)
      redirect_to product_path(@product), notice: "Product updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @product = current_user.products.new(product_create_params)
    if @product.save
      redirect_to products_path, notice: "Product added!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      redirect_to products_path, notice: "Product was deleted."
    else
      redirect_to edit_product_path(@product), alert: "Product was not deleted. Please try again."
    end
  end

  private

  def product_create_params
    params.require(:product).permit(
      :name,
      :description,
      :is_published,
      :price,
    )
  end

  def set_product
    @product = current_user.products.find(params[:id])
  end
end