class ChefsController < ApplicationController

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.create(chef_params)
    if @chef.save
      flash[:success] = 'Your credentials have been created successfully'
      redirect_to recipes_path
    else
      render 'new'
    end

  end

  def edit
  end

  def update
  end

  private

    def chef_params
      params.require(:chef).permit(:chefname, :email, :password)

    end

end