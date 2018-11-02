class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
    @ingredients = Ingredient.all
  end

  def create
    @ingredients = Ingredient.all
    @dose = Dose.new(dose_params)
    @dose.cocktail_id = Cocktail.find(params[:cocktail_id]).id
    @dose.ingredient_id = params[:dose][:ingredient_id].to_i
    if @dose.save
      redirect_to cocktail_path(@dose.cocktail_id)
    else
      render :new
    end
  end

  def show
    @dose = Dose.find(params[:id])
  end

  def destroy
    @dose = Dose.find(params[:id])
    # raise
    cocktail_id = @dose.cocktail_id
    @dose.destroy
    redirect_to cocktail_path(cocktail_id)
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id, :cocktail_id)
  end
end
