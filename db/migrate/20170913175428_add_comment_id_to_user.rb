class AddCommentIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :comment_id, :integer
  end
end
