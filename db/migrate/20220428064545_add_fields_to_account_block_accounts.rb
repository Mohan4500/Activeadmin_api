class AddFieldsToAccountBlockAccounts < ActiveRecord::Migration[6.0]
  def change
  	add_column :accounts, :is_terms_accepted, :boolean, default: 0
  end
end
