# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.date :date_of_birth
      t.string :phone
      t.string :address
      t.string :credit_card_hash
      t.string :credit_card_issuer
      t.string :credit_card_last
      t.string :email
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :contacts, %i[user_id email], unique: true
  end
end
