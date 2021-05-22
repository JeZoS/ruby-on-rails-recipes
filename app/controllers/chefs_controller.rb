class ChefsController < ApplicationController
    before_action :set_chef, only: [:show,:edit,:update,:destroy]
    before_action :requrie_same_chef , only: [:edit,:update,:destroy]
    before_action :require_admin ,only: [:destory]

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
          cookies.signed[:chef_id] = @chef.id
          flash[:success] = "Welcome #{@chef.name} to MyRecipes App!"
          redirect_to chef_path(@chef)
        else
          render 'new'
        end
    end

    def show
        @chef_recipes = @chef.recipes.paginate(page:params[:page],per_page: 5)
    end

    def edit
    end

    def update
        if @chef.update(chef_params)
          flash[:success] = "Chef was successfully updated"
          redirect_to @chef
        else
          render 'edit'
        end
    end

    def destroy
        if !@chef.admin?
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

        def set_chef
            @chef = Chef.find(params[:id])
        end

        def requrie_same_chef
            if current_chef != @chef and !current_chef.admin?
                flash[:danger] = 'Not your profile'
                redirect_to chefs_path
            end
        end
        
        def require_admin
            if logged_in? and !current_chef.admin?
                flash[:danger] = "Only admin users can perform that action"
                redirect_to root_path
            end
        end

end