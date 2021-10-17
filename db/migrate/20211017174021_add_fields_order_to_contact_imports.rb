class AddFieldsOrderToContactImports < ActiveRecord::Migration[6.1]
  def change
    add_column :contact_imports, :fields_order, :jsonb
  end
end
