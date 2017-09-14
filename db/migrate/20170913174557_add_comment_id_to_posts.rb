class AddCommentIdToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :comment_id, :integer
  end
end
