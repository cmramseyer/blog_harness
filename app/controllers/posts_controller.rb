class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update ]
  before_action :authenticate_user!, only: %i[ new create edit update ]
  before_action :authorize_author!, only: %i[ edit update ]

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

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def set_post
    @post = Post.find(params.expect(:id))
  end

  def authorize_author!
    return if @post.user == current_user

    redirect_to @post, alert: "You cannot edit this post."
  end

  def post_params
    params.expect(post: %i[ title content ])
  end
end
