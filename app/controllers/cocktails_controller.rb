class CocktailsController < ApplicationController
  before_action :find_cocktail, only: [:show, :edit, :update, :destroy]

  def index
    @cocktails = Cocktail.all
    @search = params["search"] if params["search"].present?
    if @search != "" && !@search.nil?
      @cocktails = Cocktail.joins(:ingredients).where("upper(cocktails.name) LIKE '%#{@search.upcase}%' OR upper(ingredients.name) LIKE '%#{@search.upcase}%'").uniq
    else
      @cocktails = Cocktail.all
    end
  end

  def show
    @dose = Dose.new
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

  def edit; end

  def update
    @cocktail.update(cocktail_params)
    redirect_to cocktail_path(@cocktail)
  end

  def destroy
    @cocktail.destroy
    redirect_to cocktails_path
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end

  def find_cocktail
    @cocktail = Cocktail.find(params[:id])
  end
end
