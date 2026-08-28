class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[ new create ]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, notice: "Post created."
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def post_params
    params.expect(post: %i[ title content ])
  end
end
