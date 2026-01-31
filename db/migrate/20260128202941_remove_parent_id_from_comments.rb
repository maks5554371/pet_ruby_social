class RemoveParentIdFromComments < ActiveRecord::Migration[8.0]
  def change
    remove_column :comments, :parent_id, :integer
  end
end
