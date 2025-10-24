class AddAdminToAdmins < ActiveRecord::Migration[8.0]
  def change
    add_column :admins, :admin, :boolean
  end
end
