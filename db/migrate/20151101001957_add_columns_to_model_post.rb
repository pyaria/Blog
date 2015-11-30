class AddColumnsToModelPost < ActiveRecord::Migration
  def change
    add_column :posts, :title, :string
    add_column :posts, :body, :text
    add_column :posts, :public, :boolean
  end
end
