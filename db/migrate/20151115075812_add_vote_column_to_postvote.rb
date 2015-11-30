class AddVoteColumnToPostvote < ActiveRecord::Migration
  def change
    add_column :postvotes, :vote, :boolean
  end
end
