class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :gender
      t.string :contact_number
      t.string :birth_date
      t.string :home_address
      t.string :city
      t.string :zip_code
      t.string :account_number
      t.string :account_type
      t.string :email
      t.integer :balance

      t.timestamps
    end
  end
end
