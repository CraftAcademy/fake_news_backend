class AddExpiryDateToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :expiry_date, :datetime
  end
end
