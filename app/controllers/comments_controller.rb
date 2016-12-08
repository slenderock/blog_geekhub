# frozen_string_literal: true
class CommentsController < ApplicationController
  before_action :set_post, only: [:new, :create]
  before_action :authenticate_user!

  def index
    @comments = Comment.all
  end

  def new
    @comment = @post.comments.new(parent_id: params[:parent_id])
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

  def vote
    value = params[:type] == 'up' ? 1 : -1
    @comment = Comment.find(params[:id])
    @comment.add_or_update_evaluation(:votes, value, current_user)
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
