class UsersController < ApplicationController
  def show
    @user = current_user
    @created_rice_balls = current_user.rice_balls.page(params[:created_page]).per(4)
    @bookmarked_rice_balls = current_user.bookmarked_rice_balls.page(params[:bookmarked_page]).per(4)
    end
end
