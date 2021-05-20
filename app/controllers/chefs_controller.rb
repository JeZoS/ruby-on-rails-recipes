class ChefsController < ApplicationController
   
    def index
        @chefs = Chef.paginate(page:params[:page],per_page: 5)
    end
   
    def new
        @chef = Chef.new
    end
   
    def create
        @chef = Chef.new(chef_params)
        if @chef.save
            session[:chef_id] = @chef.id
          flash[:success] = "Welcome #{@chef.name} to MyRecipes App!"
          redirect_to chef_path(@chef)
        else
          render 'new'
        end
    end

    def show
        @chef = Chef.find(params[:id])
        @chef_recipes = @chef.recipes.paginate(page:params[:page],per_page: 5)
    end

    def edit
        @chef = Chef.find(params[:id])
    end

    def update
        @chef = Chef.find(params[:id])
        if @chef.update(chef_params)
          flash[:success] = "Chef was successfully updated"
          redirect_to @chef
        else
          render 'edit'
        end
    end

    def destroy
        @chef = Chef.find(params[:id])
        if @chef.destroy
            flash[:success] = 'Chef was successfully deleted.'
            redirect_to chefs_url
        else
            redirect_to chefs_url
        end
    end
    

    private
        def chef_params
            params.require(:chef).permit(:name,:email,:password,:password_confirmation)
        end
    
end