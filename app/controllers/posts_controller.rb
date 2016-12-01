# frozen_string_literal: true
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :permission_denied, only: [:edit, :destroy]

  def index
    @posts = Post.all
    respond_to do |format|
      format.html
      format.json{ render json: @posts.to_json }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json{ render json: @post.to_json }
    end
  end

  def new
    @post = Post.new
    respond_to do |format|
      format.js
    end
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.js
        format.json { render :show, status: :created, location: @post }
      else

        format.html { redirect_to posts_url, notice: 'Please note that all fields that have an asterisk (*) are required in order to continue. ' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def permission_denied
     if @post.user != current_user
      flash[:notice] = "Sorry, you can't edit this tast"
      redirect_to(posts_path)
    end
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :body, :cover)
  end
end
