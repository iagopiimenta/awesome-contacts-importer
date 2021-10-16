class AddContactImportToContact < ActiveRecord::Migration[6.1]
  def change
    add_reference :contacts, :contact_import, null: false, foreign_key: true
  end
end
