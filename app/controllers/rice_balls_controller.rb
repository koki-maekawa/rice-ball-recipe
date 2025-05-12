class RiceBallsController < ApplicationController
  before_action :set_user, only: %i[new create edit update destroy]
  before_action :set_recipe, only: %i[edit update destroy]
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @q = RiceBall.ransack(params[:q])
    @rice_balls = @q.result(distinct: true).includes(:user, :image_attachment).order(created_at: :desc).page(params[:page]).per(12)
  end

  def show
    @rice_ball = RiceBall.find(params[:id])
    if @rice_ball.ogp_image.attached?
      set_meta_tags(
        og:      { image: @rice_ball.ogp_image.url },
        twitter: { image: @rice_ball.ogp_image.url }
      )
    end
  end

  def new
    @form = RecipeForm.new(user: @user)
  end

  def create
    @form = RecipeForm.new(user: @user, attributes: form_params)

    if @form.save
      redirect_to rice_balls_path, notice: t(".success")
    else
      render turbo_stream: [
        turbo_stream.remove("exist_form_errors"),
        turbo_stream.prepend("form_errors", partial: "shared/error_message", locals: { recipe_form: @form })
      ]
    end
  end

  def edit
    @form = RecipeForm.new(user: @user, recipe: @recipe)
  end

  def update
    @form = RecipeForm.new(user: @user, attributes: form_params, recipe: @recipe)

    if @form.save
      redirect_to rice_ball_path(@recipe), notice: t(".success")
    else
      render turbo_stream: [
        turbo_stream.remove("exist_form_errors"),
        turbo_stream.prepend("form_errors", partial: "shared/error_message", locals: { recipe_form: @form })
      ]
    end
  end

  def destroy
    rice_ball = RiceBall.find(params[:id])
    rice_ball.destroy
    redirect_to rice_balls_path, notice: t(".success")
  end

  private
    def set_user
        @user = current_user
    end

    def set_recipe
      @recipe = RiceBall.find(params[:id])
    end

    def form_params
      params.require(:recipe_form).permit(rice_ball_attributes: %i[title description image],
                                       ingredients_attributes: %i[id name amount _destroy],
                                       steps_attributes: %i[id description step_number _destroy],
                                       )
    end
end
