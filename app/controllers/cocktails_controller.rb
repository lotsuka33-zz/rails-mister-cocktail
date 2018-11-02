class CocktailsController < ApplicationController
  def home
  end

  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @doses = {}
    Dose.where(cocktail_id: @cocktail.id).each do |dose|
      @doses << { dose.description => Ingredient.find(dose.ingredient_id) }
    end
    # @ingredients = Ingredient.where(id: 1)
    # @doses = Dose.select
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end
end
