class DropActsAsTaggableOnTables < ActiveRecord::Migration[6.0]
  def up
    drop_table :taggings
    drop_table :tags
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

