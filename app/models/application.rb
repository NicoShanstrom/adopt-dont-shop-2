class Application < ApplicationRecord
	has_many :pet_applications
	has_many :pets, through: :pet_applications
	validates :name, presence: true
	validates :street_address, presence: true
	validates :city, presence: true
	validates :state, presence: true
	validates :zip_code, presence: true
	validates :description, presence: true
	validates :status, presence: true
  
	def pet_approved?(pet)
		pet_application = pet_applications.find_by(pet_id: pet.id)
		pet_application.status == "Approved"
	end

	def pet_rejected?(pet)
		pet_application = pet_applications.find_by(pet_id: pet.id)
		pet_application.status == "Rejected"
	end
end