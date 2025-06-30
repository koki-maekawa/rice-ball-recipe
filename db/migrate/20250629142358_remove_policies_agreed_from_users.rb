class RemovePoliciesAgreedFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :policies_agreed, :boolean
  end
end
