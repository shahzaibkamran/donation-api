class CreateDonations < ActiveRecord::Migration[7.1]
  def change
    create_table :donations, id: :string do |t|
      t.integer :amount
      t.references :user, foreign_key: true 
      t.references :donor, foreign_key: true 
      t.timestamps
    end
  end
end
