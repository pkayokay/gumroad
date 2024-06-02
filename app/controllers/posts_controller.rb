class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    puts "hello"
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to emails_path, notice: "Email sent!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(
      :title,
      :body,
    )
  end
end
