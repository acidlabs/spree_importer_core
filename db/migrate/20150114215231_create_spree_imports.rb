class CreateSpreeImports < ActiveRecord::Migration[4.2]
  def change
    create_table :spree_imports do |t|
      t.attachment :document
      t.datetime   :started_at
      t.datetime   :finished_at
      t.string     :state

      t.timestamps
    end
  end
end
