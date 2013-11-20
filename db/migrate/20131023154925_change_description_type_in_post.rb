class ChangeDescriptionTypeInPost < ActiveRecord::Migration

  def up
    change_column :posts, :description, :text, limit: 1024*100
  end

  def down
    change_column :posts, :description, :string
#    rename_column :posts, :body, :description
  end

end
