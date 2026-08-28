class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params.expect(:post_id))
    comment = current_user.comments.build(comment_params.merge(post:))

    if comment.save
      redirect_to post
    else
      redirect_to post, alert: "Comment cannot be blank."
    end
  end

  private

  def comment_params
    params.expect(comment: :content)
  end
end
