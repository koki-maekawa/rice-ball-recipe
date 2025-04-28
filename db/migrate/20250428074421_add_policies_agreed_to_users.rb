class AddPoliciesAgreedToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :policies_agreed, :boolean, default: false, null: false
  end
end
