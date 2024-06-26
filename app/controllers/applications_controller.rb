class ApplicationsController < ApplicationController
    def show
        @application = Application.find(params[:id])
        @pets = @application.pets
        if params[:search].present?
            @pets_found = Pet.search_name(params[:search])
        end
    end

    def new

    end

    def create 
        application = Application.new(application_params)
        if application.save
            redirect_to "/applications/#{application.id}"
        else 
            flash[:error] = "Fill in the blanks"
            redirect_to "/applications/new"
        end
    end

    def update
        app = Application.find(params[:id])
        app.update!(description: params[:description], status: "Pending")
        redirect_to "/applications/#{app.id}"
    end

    private 
    def application_params
        params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
    end
end