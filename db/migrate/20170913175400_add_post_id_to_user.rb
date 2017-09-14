class AddPostIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :post_id, :integer
  end
end
