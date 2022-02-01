class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions, id: :uuid do |t|
      t.integer :balance
      t.string :transaction_type
      t.string :transaction_id
      t.integer :amount
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
