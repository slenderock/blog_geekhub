class CommentsController < ApplicationController
  before_action :set_post, only: [:new, :show]

  def new
    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = @post.comments.create(comment_params)
    respond_to do |format|
      format.js
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
