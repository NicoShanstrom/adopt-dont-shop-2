class AddStatusToPetApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :pet_applications, :status, :string, default:'Not Approved'
  end
end
