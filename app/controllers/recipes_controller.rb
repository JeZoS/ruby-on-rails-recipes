class RecipesController < ApplicationController
    def index
        @recipes = Recipe.all
    end
    def show
        @recipe = Recipe.find(params[:id])
    end
    def new
        @recipe = Recipe.new
    end
    def create
        @recipe = Recipe.new(recipe_params)
        @recipe.chef = Chef.first
        if @recipe.save
            flash[:success] = "Recipe was created successfully!"
            redirect_to recipe_url(@recipe)
        else
            render 'new'
        end
    end

    def edit
        @recipe = Recipe.find(params[:id])
    end

    def update
        @recipe = Recipe.find(params[:id])
        if @recipe.update(recipe_params)
            flash[:notice] = 'Recipe updated successfully'
            redirect_to recipe_url(@recipe)
        else
            render 'edit'
        end
    end

    def destroy
        @recipe = Recipe.find(params[:id])
        @recipe.destroy
        flash[:notice] = 'Recipe deleted successfully'
        redirect_to recipes_path
    end

    private
        def recipe_params
            params.require(:recipe).permit(:name,:description)
        end
end