class ReviewsController < ApplicationController
  before_action :set_recipe
  before_action :require_user, except: [:show]
  before_action :require_different_user, except: [:show]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.chef = current_user
    @review.recipe = @recipe

    if @review.save
      flash[:success] = "Your review was created successfully!"
      redirect_to recipe_review_path(@recipe, @review)
    else
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  private

    def review_params
      params.require(:review).permit(:title, :body)
    end

    def set_recipe
      @recipe = Recipe.find(params[:recipe_id])
    end

    def require_different_user
      if current_user == @recipe.chef
        flash[:danger] = "You cannot review your own recipes"
        redirect_to recipe_path(@recipe)
      end
    end

end