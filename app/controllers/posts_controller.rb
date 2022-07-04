# frozen_string_literal: true

# class PostsController
class PostsController < ApplicationController
  before_action :authorize
  skip_before_action :authorize, only: :index
  before_action :set_post, only: %i[show edit update destroy]
  before_action :permit, only: %i[edit update destroy]

  def index
    @posts = Post.all
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(user_id: session[:user_id], title: post_params[:title], body: post_params[:body])
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def edit; end

  def destroy
    @post.destroy

    redirect_to posts_path
  end

  private

  def permit
    return unless session[:user_id] != @user.id && session[:user_id] != 1

    redirect_to @post, notice: 'You trying to access without permit?'
  end

  def set_post
    @post = Post.find(params[:id])
    @user = User.find_by_id(@post.user_id)
    @user_session = User.find_by_id(session[:user_id]).name
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
