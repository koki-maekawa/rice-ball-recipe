class RecipeForm < FormBase
    attr_accessor :rice_ball
    attr_accessor :ingredients
    attr_accessor :steps

    delegate :id, :persisted?, to: :rice_ball
    def initialize(user:, attributes: nil, recipe: nil)
      @user = user
      @rice_ball = recipe || RiceBall.new(user: @user)
      @ingredients = recipe&.ingredients
      @steps = recipe&.steps
      super(attributes: attributes)
    end

    def rice_ball_attributes=(other)
      rice_ball.attributes = other
    end

    def ingredients_attributes=(others)
      @ingredients = others.values.map do |other|
        other = other.dup
        id = other[:id].to_i if other[:id].present?
        if id.present?
          if other[:_destroy].to_s == "true"
            Ingredient.find(id).destroy
            next nil
          else
            ingredient = Ingredient.find(id)
            other.delete(:_destroy)
            ingredient.assign_attributes(other)
            ingredient
          end
        else
          next nil if other[:_destroy].to_s == "true"
          ingredient = Ingredient.new(rice_ball: @rice_ball)
          other.delete(:_destroy)
          ingredient.assign_attributes(other)
          ingredient
        end
      end.compact
    end

    def steps_attributes=(others)
      @steps = others.values.map do |other|
        other = other.dup
        id = other[:id].to_i if other[:id].present?
        if id.present?
          if other[:_destroy].to_s == "true"
            Step.find(id).destroy
            next nil
          else
            step = Step.find(id)
            other.delete(:_destroy)
            step.assign_attributes(other)
            step
          end
        else
          next nil if other[:_destroy].to_s == "true"
          step = Step.new(rice_ball: @rice_ball)
          other.delete(:_destroy)
          step.assign_attributes(other)
          step
        end
      end.compact
    end

    private

    attr_reader :user

    def default_attributes
      {
        rice_ball: rice_ball,
        ingredients: ingredients,
        steps: steps
      }
    end

    def persist
      raise ActiveRecord::RecordInvalid if [ rice_ball, *ingredients, *steps ].select(&:invalid?).present?

      ActiveRecord::Base.transaction do
        rice_ball.save!
        ingredients.each(&:save!)
        steps&.each(&:save!)
      end

      true
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved
      errors_from_rice_ball
      errors_from_ingredients
      errors_from_steps
      false
    end

    def errors_from_rice_ball
        rice_ball.errors.each do |error|
        errors.add(:base, error.full_message)
      end
    end

    def errors_from_ingredients
      ingredients.each do |ingredient|
        ingredient.errors.each do |error|
            errors.add(:base, error.full_message)
        end
      end
    end

    def errors_from_steps
      steps&.each do |step|
        step.errors.each do |error|
            errors.add(:base, error.full_message)
        end
      end
    end
end
