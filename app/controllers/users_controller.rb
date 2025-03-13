class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @created_rice_balls = @user.rice_balls.page(params[:created_page]).per(4)
    @bookmarked_rice_balls = @user.bookmarked_rice_balls.page(params[:bookmarked_page]).per(4)
    end
end
