class AddVotesCached < ActiveRecord::Migration
  def change
    add_column :answers, :cached_weighted_total, :integer, :default => 0
    add_column :questions, :cached_weighted_total, :integer, :default => 0
  end
end
