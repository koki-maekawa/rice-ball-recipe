class TagsController < ApplicationController
  before_action :set_tag, only: %i[show]

  def show
    @rice_balls = @tag.rice_balls
                    .includes(:user, :image_attachment, :tags)
                    .order(created_at: :desc)
                    .page(params[:page]).per(12)
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
