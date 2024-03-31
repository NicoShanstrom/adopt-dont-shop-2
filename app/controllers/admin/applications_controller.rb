class Admin::ApplicationsController < ApplicationController
    def show
        @application = Application.find(params[:id])
        @pets = @application.pets
    end

    def update
        @application = Application.find(params[:id])
        @pet = Pet.find(params[:pet_id])
        @application.approve_pet(@pet)
        redirect_to "/admin/applications/#{@application.id}"
    end
end