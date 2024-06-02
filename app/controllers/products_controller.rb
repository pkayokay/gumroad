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
    transaction = Product.transaction do
      @product.update(product_create_params)
      if @product.product_category.category_id != params[:product][:category_id].to_i
        @product.product_category.update(category_id: params[:product][:category_id].to_i)
      end
    end

    if transaction
      redirect_to product_path(@product), notice: "Product updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @product = current_user.products.new(product_create_params)

    transaction = Product.transaction do
      @product.save
      ProductCategory.create!(product: @product, category_id: params[:product][:category_id])
    end

    if transaction
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