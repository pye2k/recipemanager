class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @recipe = Recipe.find(params[:recipe_id])
  end

  def create
    @review = Review.new(review_params)
    @review.chef = Chef.first
    @review.recipe_id = params[:recipe_id]

    if @review.save
      flash[:success] = "Your review was created successfully!"
      redirect_to recipe_review_path(params[:recipe_id], @review)
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

end