class CreateDonors < ActiveRecord::Migration[7.1]
  def change
    create_table :donors do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :phone_number
      t.timestamps
    end
  end
end
