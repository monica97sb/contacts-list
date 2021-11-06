class ChangeFieldsToMandatory < ActiveRecord::Migration[6.1]
  def change
    change_column :contacts, :first_name, :string, presence: true, allow_blank: false
    change_column :contacts, :last_name, :string, presence: true, allow_blank: false
    change_column :contacts, :email, :string, presence: true, allow_blank: false
    change_column :contacts, :phone, :string, presence: true, allow_blank: false
  end
end
