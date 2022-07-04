# frozen_string_literal: true

# class LikesController
class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    if @post.likes.all? { |like| like.user_id != session[:user_id] }
      @like = @post.likes.create(user_id: session[:user_id])
    end
    redirect_to post_path(@post)
  end

  def show
    @post = Post.find(params[:post_id])
    @like = @post.likes.find(params[:id])
    @like.destroy
    redirect_to post_path(@post)
  end
end
