class AddTotalRowsToContactImports < ActiveRecord::Migration[6.1]
  def change
    add_column :contact_imports, :total_rows, :integer
  end
end
