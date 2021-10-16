class CreateContactImports < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_imports do |t|
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
