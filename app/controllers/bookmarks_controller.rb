class BookmarksController < ApplicationController
  def create
    rice_ball = RiceBall.find(params[:rice_ball_id])
    bookmark = current_user.bookmarks.new(rice_ball_id: rice_ball.id)
    bookmark.save
    render turbo_stream: turbo_stream.update("bookmark_rice_ball_#{rice_ball.id}", partial: "shared/bookmark", locals: { rice_ball: rice_ball, size: params[:size] })
  end

  def destroy
    rice_ball = RiceBall.find(params[:rice_ball_id])
    bookmark = current_user.bookmarks.find_by(rice_ball_id: rice_ball.id)
    bookmark.destroy
    render turbo_stream: turbo_stream.update("bookmark_rice_ball_#{rice_ball.id}", partial: "shared/bookmark", locals: { rice_ball: rice_ball, size: params[:size] })
  end
end
