class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def update
    @application = Application.find(params[:id])
    @pet_application = PetApplication.find_by(pet_id: params[:pet_id], application_id: params[:id])
    if params[:status] == "Approved"
      @pet_application.approve_pet
      redirect_to "/admin/applications/#{@application.id}"
    elsif params[:status] == "Rejected"
      @pet_application.reject_pet
      redirect_to "/admin/applications/#{@application.id}"
    end
  end
end