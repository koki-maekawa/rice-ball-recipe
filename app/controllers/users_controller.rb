class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @created_rice_balls = @user.rice_balls.includes(:image_attachment).order(created_at: :desc).page(params[:created_page]).per(4)
    @bookmarked_rice_balls = @user.bookmarked_rice_balls.includes(:image_attachment).order("bookmarks.created_at DESC").page(params[:bookmarked_page]).per(4)
  end
end
