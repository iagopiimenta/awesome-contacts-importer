class CreateContactFaileds < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_faileds do |t|
      t.integer :line_number
      t.references :contact_import, null: false, foreign_key: true
      t.jsonb :messages
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
