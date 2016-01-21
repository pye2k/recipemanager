class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :like]
  before_action :require_user, except: [:show, :index, :like]
  before_action :require_user_for_like, only: [:like]
  before_action :require_same_user_or_admin, only: [:edit, :update]

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 4)
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_user

    if @recipe.save
      flash[:success] = "Your recipe was created successfully!"
      redirect_to recipes_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated successfully"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def like
    like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your selection was successfully logged"
      redirect_to :back
    else
      flash[:danger] = "You can only like/dislike a recipe once"
      redirect_to :back
    end

  end

  private

    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture, style_ids: [], ingredient_ids: [])
    end

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def require_same_user_or_admin
      if current_user != @recipe.chef and !current_user.admin?
        flash[:danger] = "You can only update receipes that you own"
        redirect_to recipes_path
      end
    end

    def require_user_for_like
      if !logged_in?
        flash[:danger] = "You must be logged in to perform that action"
        redirect_to :back
      end
    end

end