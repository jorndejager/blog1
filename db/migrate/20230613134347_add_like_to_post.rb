class AddLikeToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :likes, :integer, default: 0


  end
end
