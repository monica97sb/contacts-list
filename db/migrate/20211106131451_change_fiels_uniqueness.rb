class ChangeFielsUniqueness < ActiveRecord::Migration[6.1]
  def change
    change_column :contacts, :email, :string, unique: true
  end
end
