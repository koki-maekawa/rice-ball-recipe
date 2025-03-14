class BookmarksController < ApplicationController
  def create
    rice_ball = RiceBall.find(params[:rice_ball_id])
    bookmark = current_user.bookmarks.new(rice_ball_id: rice_ball.id)
    bookmark.save
    redirect_to request.referer
  end

  def destroy
    rice_ball = RiceBall.find(params[:rice_ball_id])
    bookmark = current_user.bookmarks.find_by(rice_ball_id: rice_ball.id)
    bookmark.destroy
    redirect_to request.referer
  end
end
