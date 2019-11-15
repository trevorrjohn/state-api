class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses, id: :uuid do |t|
      t.text :name, null: false
      t.string :street, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :country, null: false

      t.timestamps
    end

    add_index :addresses, %i[state country]
  end
end
