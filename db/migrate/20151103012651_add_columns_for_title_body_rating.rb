class AddColumnsForTitleBodyRating < ActiveRecord::Migration
  def change
    add_column :comments, :title, :string
    add_column :comments, :rating, :integer
    add_column :comments, :body, :text
  end
end
