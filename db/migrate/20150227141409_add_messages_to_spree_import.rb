class AddMessagesToSpreeImport < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_imports, :messages, :text
  end
end
