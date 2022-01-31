class CreateJwtDenylists < ActiveRecord::Migration[6.1]
  def change
    create_table :jwt_denylist, id: :uuid do |t|
      t.string :jti
      t.datetime :exp

      t.timestamps
    end
    add_index :jwt_denylist, :jti
  end
end
