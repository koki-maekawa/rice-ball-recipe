class RiceBallsController < ApplicationController
  before_action :set_user, only: %i[new create]
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @q = RiceBall.ransack(params[:q])
    @rice_balls = @q.result(distinct: true).includes(:ingredients).page(params[:page]).per(8)
  end

  def show
    @rice_ball = RiceBall.find(params[:id])
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
  end

  def update
  end

  def destroy
  end

  private
    def set_user
        @user = current_user
    end

    def form_params
      params.require(:recipe_form).permit(rice_ball_attributes: %i[title image],
                                       ingredients_attributes: %i[id name amount _destroy],
                                       steps_attributes: %i[id description step_number _destroy],
                                       )
    end
end
