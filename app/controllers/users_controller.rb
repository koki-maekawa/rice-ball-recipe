class UsersController < ApplicationController
  before_action :set_user, only: %i[show created_index bookmarked_index]

  def show
    @created_rice_balls = @user.rice_balls.includes(:image_attachment).order(created_at: :desc).limit(2)
    @created_rice_balls_count = @user.rice_balls.size
    @bookmarked_rice_balls = @user.bookmarked_rice_balls.includes(:image_attachment, :user).order("bookmarks.created_at DESC").limit(2)
    @bookmarked_rice_balls_count = @user.bookmarked_rice_balls.size
  end

  def created_index
    @created_rice_balls = @user.rice_balls.includes(:image_attachment).order(created_at: :desc).page(params[:page]).per(8)
  end

  def bookmarked_index
    @bookmarked_rice_balls = @user.bookmarked_rice_balls.includes(:image_attachment, :user).order("bookmarks.created_at DESC").page(params[:page]).per(8)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
