class AddImporterToSpreeImports < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_imports, :importer, :string
  end
end
