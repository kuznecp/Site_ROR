# frozen_string_literal: true

# class CommentsController
class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(user_id: session[:user_id], body: comment_params[:body])
    redirect_to post_path(@post)
  end

  def show
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.required(:comment).permit(:body)
  end
end
