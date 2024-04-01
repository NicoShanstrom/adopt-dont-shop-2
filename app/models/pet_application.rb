class PetApplication < ApplicationRecord
    belongs_to :application
    belongs_to :pet

    def approve_pet
       update(status: "Approved")
    end

    def reject_pet
        update(status: "Rejected")
	end
end